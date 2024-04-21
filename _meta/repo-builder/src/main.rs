use std::env;
use std::fs;
use std::path::Path;
use std::process::Command;

use chrono::NaiveDateTime;
use chrono::TimeZone;
use chrono_tz::US::Pacific;
use serde::Deserialize;

#[derive(Deserialize, Debug)]
struct Solution {
    // uuid: String,
    last_iterated_at: String,
    track: String,
    exercise: String,
    // status: String,
}

fn run_command(cmd: &mut Command) {
    let result = cmd.output().expect("unable to execute command");

    if !result.status.success() {
        panic!(
            "\ncommand `{:?}` exited unsuccessfully: {}",
            cmd,
            String::from_utf8(result.stderr).unwrap()
        );
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() != 2 {
        panic!(
            "Expected exactly 1 argument (a path to a bunch of JSON), got {} instead",
            args.len() - 1
        );
    }

    let solutions_path = &args[1];
    let json_str = fs::read_to_string(solutions_path)
        .unwrap_or_else(|_| panic!("failed to read file at path {solutions_path}"));
    let solutions: Vec<Solution> =
        serde_json::from_str(&json_str).unwrap_or_else(|err| panic!("Unable to parse JSON: {err}"));

    // safe to re-run
    run_command(Command::new("git").arg("init"));

    for solution in solutions {
        if solution.exercise == "hello-world" {
            continue;
        }

        let exercise_path = format!("./{}/{}", solution.track, solution.exercise);
        let path = Path::new(&exercise_path);
        if !path.exists() {
            println!(
                "!! missing {}.{}, downloading...",
                solution.track, solution.exercise
            );

            // exercism download --track=go --exercise=hello-world
            run_command(
                Command::new("exercism")
                    .arg("download")
                    .arg("--track")
                    .arg(&solution.track)
                    .arg("--exercise")
                    .arg(&solution.exercise),
            );
        }

        let naive_time =
            NaiveDateTime::parse_from_str(&solution.last_iterated_at, "%Y-%m-%dT%H:%M:%SZ")
                .unwrap();
        let local_time = Pacific.from_utc_datetime(&naive_time);

        run_command(Command::new("git").arg("add").arg(exercise_path));

        run_command(
            Command::new("git")
                .env("GIT_COMMITTER_DATE", local_time.to_string())
                .env("GIT_AUTHOR_DATE", local_time.to_string())
                .arg("commit")
                .arg("-m")
                .arg(format!("{}: {}", solution.track, solution.exercise)),
        );
        println!("committed {}.{}", solution.track, solution.exercise)
    }
}

_default:
    just --list

# run this from an exercise directory to make a commit with that directory's files
[no-cd]
@commit:
    {{ assert(path_exists(invocation_directory()/".exercism/metadata.json") == "true", "Call this from an exercise directory (missing .exercism/metadata.json)") }}

    git add .
    gg "$(cat .exercism/metadata.json | jq '.track' -r): $(cat .exercism/metadata.json | jq '.exercise' -r)"

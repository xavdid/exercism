Fetch JSON using private API; run in a `_meta` folder:

```zsh
# this could go very high, but I only had 5 pages
# opening https://exercism.org/api/v2/solutions in a browser will show you how many pages you have (at the bottom)
for p in 1 2 3 4 5; do
    curl "https://exercism.org/api/v2/solutions?page=$p" -H 'authorization: Bearer <YOUR TOKEN HERE>' > "solutions/$p.json"
done
```

Generated solutions using `jq`; run from within the `_meta` folder:

```
jq -s '[.[] | .results[] | {uuid, last_iterated_at, track: .track.slug, exercise: .exercise.slug, status}] | map(select(.status != "started"))| unique | sort_by(.last_iterated_at)' solutions/* > all_solutions.json
```

Finally, from the **repo root**, run:

```
cargo run --manifest-path _meta/repo-builder/Cargo.toml _meta/all_solutions.json
```

Which will commit each subfolder, in order, based on the contents of `all_solutions.json`.

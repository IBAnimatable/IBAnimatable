# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
not_declared_trivial = !(github.pr_title.include? "#no-public-changes")
has_app_changes = !git.modified_files.grep(/Sources/).empty?

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# Changelog entries are required for changes to library files.
no_changelog_entry = !git.modified_files.include?("CHANGELOG.md")
if has_app_changes && no_changelog_entry && not_declared_trivial
  fail("Any changes to library code need a summary in the Changelog.")
end

missing_doc_changes = git.modified_files.grep(/Documentation/).empty?
doc_changes_recommended = git.insertions > 15
if has_app_changes && missing_doc_changes && doc_changes_recommended
  warn("Consider adding supporting documentation to this change. Documentation can be found in the `docs` directory.")
end

missing_example_app_update = git.modified_files.grep(/IBAnimatableApp/).empty?
demo_app_changes_recommended = git.insertions > 15
if has_app_changes && missing_example_app_update && demo_app_changes_recommended
  warn("Consider adding / updating the demo app.")
end

# Run SwiftLint
swiftlint.lint_files

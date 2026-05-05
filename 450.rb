# Other solutions:
# https://web.archive.org/web/20260408142423/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-450/222
#
# Instructions:
#
# You are given a file system represented as an object where keys are absolute
# paths and values are either null (real file/directory) or a string (a symlink
# pointing to another path). Write a function that resolves a given path to its
# real destination, following symlinks along the way. If a symlink chain forms a
# cycle, return null.
#
# Examples:
#
#     const fs = {
#       "/a": "/b",
#       "/b": "/c",
#       "/c": null,
#       "/loop1": "/loop2",
#       "/loop2": "/loop1",
#       "/real": null,
#       "/alias": "/real",
#     };
#
#     resolvePath(fs, "/a");      // "/c"
#     resolvePath(fs, "/alias");  // "/real"
#     resolvePath(fs, "/loop1");  // null
#     resolvePath(fs, "/real");   // "/real"
#
# Source:
# https://buttondown.com/cassidoo/archive/u1f360-id-rather-regret-the-things-ive-done-than/

def resolve_path(filesystem, path, visited_paths = [])
  return nil if visited_paths.include?(path)
  visited_paths << path

  if filesystem[path].nil?
    path
  else
    resolve_path(filesystem, filesystem[path], visited_paths)
  end
end

# Tests

fs = {
  "/a" => "/b",
  "/b" => "/c",
  "/c" => nil,
  "/loop1" => "/loop2",
  "/loop2" => "/loop1",
  "/real" => nil,
  "/alias" => "/real"
}

raise unless resolve_path(fs, "/a") == "/c"
raise unless resolve_path(fs, "/alias") == "/real"
raise unless resolve_path(fs, "/loop1").nil?
raise unless resolve_path(fs, "/real") == "/real"
puts "✓ Tests passed"

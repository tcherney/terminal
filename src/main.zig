const std = @import("std");
const term = @import("term.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var terminal = try term.Term.init(allocator);
    try terminal.set_bg_color(40, 40, 40);
    try terminal.set_fg_color(255, 128, 0);
    try terminal.out("hello world\n");
    var running = true;
    while (running) {
        const byte = try terminal.stdin.readByte();
        if (byte == 'q') {
            running = false;
        }
    }
    try terminal.deinit();

    if (gpa.deinit() == .leak) {
        std.debug.print("Leaked!\n", .{});
    }
}

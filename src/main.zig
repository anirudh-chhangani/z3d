// https://www.youtube.com/watch?v=qjWkNZ0SXfo

const std = @import("std");
const rl = @import("raylib");

const Io = std.Io;

const z3d = @import("z3d");
const screenWidth = 800;
const screenHeight = 800;

const verticies = [_]Point{
    Point{ .x = 0.25, .y = 0.25, .z = 0.25 },
    Point{ .x = -0.25, .y = 0.25, .z = 0.25 },
    Point{ .x = -0.25, .y = -0.25, .z = 0.25 },
    Point{ .x = 0.25, .y = -0.25, .z = 0.25 },

    Point{ .x = 0.25, .y = 0.25, .z = -0.25 },
    Point{ .x = -0.25, .y = 0.25, .z = -0.25 },
    Point{ .x = -0.25, .y = -0.25, .z = -0.25 },
    Point{ .x = 0.25, .y = -0.25, .z = -0.25 },
};

const faces = [_][]const i32{
    &[_]i32{ 0, 1, 2, 3 },
    &[_]i32{ 4, 5, 6, 7 },
    &[_]i32{ 0, 4 },
    &[_]i32{ 1, 5 },
    &[_]i32{ 2, 6 },
    &[_]i32{ 3, 7 },
};

pub fn main(init: std.process.Init) !void {
    _ = init;

    rl.initWindow(screenWidth, screenHeight, "Demystifying shaders");
    defer rl.closeWindow();
    const FPS = 60;
    rl.setTargetFPS(FPS);
    const dz: f32 = 1;
    var angle: f32 = 0;
    // Main game loop
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        const dt: f32 = 1.0 / 60.0;
        // dz += 1 * dt;
        angle += dt * 3.14;
        clearScreen();
        // for (verticies) |v| {
        //     point(screen(project(translate_z(rotate_xz(v, angle), dz))), 20, 20, .green);
        // }
        for (faces) |face| {
            for (0..face.len) |i| {
                const l1 = verticies[@intCast(face[i])];
                const l2 = verticies[@intCast(face[(i + 1) % face.len])];
                const p1 = screen(project(translate_z(rotate_xz(l1, angle), dz)));
                const p2 = screen(project(translate_z(rotate_xz(l2, angle), dz)));
                line(p1, p2, .green);
            }
        }
        rl.waitTime(0.001 / 60.0);
    }
}

fn clearScreen() void {
    rl.clearBackground(.black);
    rl.drawRectangle(0, 0, screenWidth, screenHeight, .black);
}

fn point(gpoint: Point, width: i32, height: i32, color: rl.Color) void {
    const position = rl.Vector2.init(gpoint.x, gpoint.y);
    const size = rl.Vector2.init(@floatFromInt(width), @floatFromInt(height));
    rl.drawRectangleV(position, size, color);
}

const Point = struct {
    x: f32,
    y: f32,
    z: f32,
};

fn screen(gpoint: Point) Point {
    const x = (gpoint.x + 1) / 2 * screenWidth;
    const y = (1 - (gpoint.y + 1) / 2) * screenHeight;
    const projection = Point{
        .x = x,
        .y = y,
        .z = gpoint.z,
    };
    return projection;
}

fn project(gpoint: Point) Point {
    const x = gpoint.x / gpoint.z;
    const y = gpoint.y / gpoint.z;
    const projection = Point{
        .x = x,
        .y = y,
        .z = gpoint.z,
    };
    return projection;
}

fn translate_z(gpoint: Point, dz: f32) Point {
    return Point{
        .x = gpoint.x,
        .y = gpoint.y,
        .z = gpoint.z + dz,
    };
}

fn rotate_xz(gpoint: Point, angle: f32) Point {
    const cos = @cos(angle);
    const sin = @sin(angle);
    return Point{
        .x = gpoint.x * cos - gpoint.z * sin,
        .y = gpoint.y,
        .z = gpoint.x * sin + gpoint.z * cos,
    };
}

fn line(gpoint1: Point, gpoint2: Point, color: rl.Color) void {
    rl.drawLineV(
        rl.Vector2.init(gpoint1.x, gpoint1.y),
        rl.Vector2.init(gpoint2.x, gpoint2.y),
        color,
    );
}

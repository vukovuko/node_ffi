#include <node.h>
#include <raylib.h>

void InitRaylibWindow(const v8::FunctionCallbackInfo<v8::Value>& args) {
    const int screenWidth = 800;
    const int screenHeight = 600;

    InitWindow(screenWidth, screenHeight, "Raylib window from Node.js");

    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        BeginDrawing();

        ClearBackground(RAYWHITE);

        DrawText("Congrats! You created a window!", 190, 200, 20, LIGHTGRAY);

        EndDrawing();
    }

    CloseWindow();
}

void Hello(const v8::FunctionCallbackInfo<v8::Value>& args) {
    v8::Isolate* isolate = args.GetIsolate();
    args.GetReturnValue().Set(
        v8::String::NewFromUtf8(isolate, "Hello, world!",
                                v8::NewStringType::kNormal)
            .ToLocalChecked());
}

void Initialize(v8::Local<v8::Object> exports) {
    NODE_SET_METHOD(exports, "Hello", Hello);
    NODE_SET_METHOD(exports, "InitRaylibWindow", InitRaylibWindow);
}

NODE_MODULE(NODE_GYP_MODULE_NAME, Initialize)

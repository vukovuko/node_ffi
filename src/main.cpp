#include <node.h>
#include <raylib.h>

void InitRaylibWindow(const v8::FunctionCallbackInfo<v8::Value>& args) {
    v8::Isolate* isolate = args.GetIsolate();
    v8::Local<v8::Context> context = isolate->GetCurrentContext();

    int screenWidth = 800;
    int screenHeight = 600;
    const char* windowTitle = "Hello from CPP";
    const char* drawTextContent = "Text from CPP";

    v8::String::Utf8Value title(isolate, args[2]);
    v8::String::Utf8Value text(isolate, args[3]);

    if (args.Length() > 0 && args[0]->IsNumber()) {
        screenWidth = args[0]->Int32Value(context).ToChecked();
    }
    if (args.Length() > 1 && args[1]->IsNumber()) {
        screenHeight = args[1]->Int32Value(context).ToChecked();
    }

    if (args.Length() > 2 && args[2]->IsString()) {
        windowTitle = *title;
    }

    if (args.Length() > 3 && args[3]->IsString()) {
        drawTextContent = *text;
    }

    InitWindow(screenWidth, screenHeight, windowTitle);
    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(RAYWHITE);

        DrawText(drawTextContent, 190, 200, 20, LIGHTGRAY);

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

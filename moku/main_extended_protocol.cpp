#include "config.hpp"
#include "engine/extended_protocol/extended_protocol.hpp"

#include <string_view>

int main(int argc, char* argv[])
{
    for (int i = 1; i < argc; ++i)
    {
        if (std::string_view(argv[i]) == "--debug-output")
        {
            g_config.debug_output = true;
        }
    }

    Engine engine;
    engine.run();
}
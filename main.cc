#include <sstream>
#include <cassert>
#include <cstdlib>
#include "scanner.h"
#include "parser.c"

int main() {
    YYSTYPE yylval;
    Scanner scanner(&std::cin);
    void *pParser = ParseAlloc(malloc);
    int tokenID;

#if 0
    ParseTrace(stderr, (char*)"[Parser] >> ");
#endif

    ParserState state;
    // scanner.scan return 0 when get EOF.
    while (tokenID = scanner.scan(yylval)) {
        // printf("GET TOKEN: %d\n", tokenID);
        Parse(pParser, tokenID, yylval, &state);
    }
    Parse(pParser, 0, yylval, &state);
    ParseFree(pParser, free);

    printf("RESULT: %d\n", state.result);
    return 0;
}


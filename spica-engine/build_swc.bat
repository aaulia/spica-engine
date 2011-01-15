@echo off
@compc --include-sources ./spica -optimize -strict -omit-trace-statements -target-player 10.1 -output ./spica-engine.swc
@pause

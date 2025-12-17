; queries/highlights.scm

["NewPage" "Section" "SubSection" "VStack" "HStack" "ZStack" "Text" "Image" "Spacer" "Divider" "Math" "Listing"] @contentKeyword

["Color" "Alignment" "HorizontalAlignment" "VerticalAlignment" "Edge" "Axis" "FontSize" "FontStyle" "LinePattern" "CodeLanguage" "CodeStyle" "CodeFrame"] @typeKeyword

["alignment" "header" "footer" "width" "height" "layout" "padding" "offset" "margin" "enumerated" "caption" "subfigure" "spacing" "tint" "background" "textAlignment" "lineSpacing" "underline" "strikethrough" "fontSize" "fontStyle" "language" "style" "frame" "numbers"] @modifierKeyword

(horizontal_alignment_value) @valueKeyword
(vertical_alignment_value) @valueKeyword
(alignment_value) @valueKeyword
(edge_value) @valueKeyword
(axis_value) @valueKeyword
(color_value) @valueKeyword
(line_pattern_value) @valueKeyword
(font_size_value) @valueKeyword
(font_style_value) @valueKeyword
(code_language_value) @valueKeyword
(code_style_value) @valueKeyword
(code_frame_value) @valueKeyword

(bool_type) @boolean
(number) @number
(constant) @constant

(add_operation) @operation
(mul_operation) @operation

["." "," "(" ")" "{" "}"] @symbol

(raw_text) @text
(raw_arg_text) @text

(math_text) @math
(math_inline_text) @math
(math_separator) @math

(file_name) @filename

(newline) @newline

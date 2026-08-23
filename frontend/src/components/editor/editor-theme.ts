// Catppuccin Mocha theme for Monaco Editor
// https://catppuccin.com/palette/mocha/

export const questTheme = {
  base: 'vs-dark',
  inherit: true,
  rules: [
    { token: 'keyword', foreground: 'cba6f7' },       // Mauve
    { token: 'string', foreground: 'a6e3a1' },          // Green
    { token: 'number', foreground: 'fab387' },          // Peach
    { token: 'comment', foreground: '6c7086' },        // Overlay0
    { token: 'type', foreground: '89b4fa' },            // Blue
    { token: 'delimiter', foreground: 'b4befe' },       // Lavender
    { token: 'identifier', foreground: 'cdd6f4' },    // Text
    { token: 'attribute.name', foreground: 'fab387' }, // Peach
    { token: 'attribute.value', foreground: 'a6e3a1' },// Green
    { token: 'tag', foreground: 'cba6f7' },            // Mauve
  ],
  colors: {
    // Base backgrounds
    'editor.background': '#1e1e2e',               // Base
    'editor.foreground': '#cdd6f4',               // Text
    'editorLineNumber.foreground': '#6c7086',    // Overlay0
    'editorLineNumber.activeForeground': '#cdd6f4', // Text
    'editor.selectionBackground': '#585b70aa',   // Surface2
    'editor.inactiveSelectionBackground': '#585b7066',
    'editor.selectionHighlightBackground': '#585b7044',
    'editor.lineHighlightBackground': '#181826',   // Mantle
    'editor.lineHighlightBorder': '#00000000',
    'editorCursor.foreground': '#f5e0dc',         // Rosewater
    'editorIndentGuide.background': '#313244',    // Surface0
    'editorIndentGuide.activeBackground': '#585b70', // Surface2
    'editorGutter.background': '#1e1e2e',         // Base
    'editorGutter.modifiedBackground': '#fab387', // Peach
    'editorGutter.addedBackground': '#a6e3a1',    // Green
    'editorGutter.deletedBackground': '#f38ba8', // Red

    // Widgets
    'editorWidget.background': '#181826',        // Mantle
    'editorWidget.border': '#313244',           // Surface0
    'editorSuggestWidget.background': '#181826', // Mantle
    'editorSuggestWidget.border': '#313244',    // Surface0
    'editorSuggestWidget.selectedBackground': '#313244', // Surface0
    'editorSuggestWidget.highlightForeground': '#cba6f7', // Mauve

    // Find/Replace
    'editor.findMatchBackground': '#585b70aa',
    'editor.findMatchHighlightBackground': '#585b7044',

    // Hover
    'editorHoverWidget.background': '#181826',
    'editorHoverWidget.border': '#313244',

    // Bracket matching
    'editorBracketMatch.background': '#585b7066',
    'editorBracketMatch.border': '#cba6f7',      // Mauve

    // Scrollbar
    'editorScrollbar.shadow': '#00000000',
    'editorScrollbarSlider.background': '#585b7066',
    'editorScrollbarSlider.hoverBackground': '#585b70aa',
    'editorScrollbarSlider.activeBackground': '#585b70cc',

    // Peek view
    'peekView.border': '#cba6f7',
    'peekViewEditor.background': '#1e1e2e',
    'peekViewResult.background': '#181826',
    'peekViewResult.selectionBackground': '#313244',

    // Overview ruler
    'editorOverviewRuler.border': '#00000000',
  },
};
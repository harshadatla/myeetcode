'use client';

import { useRef } from 'react';
import Editor from '@monaco-editor/react';
import { questTheme } from './editor-theme';

interface CodeEditorProps {
  value: string;
  onChange: (value: string) => void;
}

export function CodeEditor({ value, onChange }: CodeEditorProps) {
  const editorRef = useRef(null);

  const handleBeforeMount = (monaco: any) => {
    monaco.editor.defineTheme('quest', questTheme);
  };

  const handleMount = (editor: any) => {
    editorRef.current = editor;
  };

  return (
    <div className="h-full w-full bg-background">
      <Editor
        height="100%"
        language="java"
        theme="quest"
        beforeMount={handleBeforeMount}
        onMount={handleMount}
        value={value}
        onChange={(v) => onChange(v || '')}
        options={{
          fontSize: 14,
          fontFamily: 'JetBrains Mono, monospace',
          minimap: { enabled: false },
          scrollBeyondLastLine: false,
          padding: { top: 16, bottom: 16 },
          fontLigatures: true,
          smoothScrolling: true,
          cursorBlinking: 'smooth',
          tabSize: 4,
          automaticLayout: true,
          wordWrap: 'on',
          lineNumbersMinChars: 3,
          renderLineHighlight: 'all',
          scrollbar: {
            verticalScrollbarSize: 8,
            horizontalScrollbarSize: 8,
          },
        }}
      />
    </div>
  );
}
unit U_Const;

interface

const
  TITLE_NEW = 'Open';
  TITLE_SAVE = 'Save';

  TITLE_FORM = '%s - CodeEditor2 Demo';
  TITLE_ABOUT = 'About';
  TITLE_FIND = 'Find';
  TITLE_LOAD_XML_CONFIG = 'Load config';
  FILE_DEFAULT_NAME = 'Unnamed %d';

  MSG_OPEN_FILE_ERROR = 'Cannot open file'#34'%s'#34#13#10'%s';
  MSG_NODE_NOT_FOUND = 'Cannot Find Node "%s"';

  PROMOPT_SAVE = 'Save changes?';

  STATUS_MODIFIED = 'Modified';
  STATUS_INSERT = 'Insert';
  STATUS_OVERWRITE = 'Overwrite';

  ENCODING_UNKNOWN = 'Unknown encoding';
  ENCODING_ANSI = 'ANSI';
  ENCODING_UTF16 = 'Unicode';
  ENCODING_UTF8 = 'UTF-8';
  ENCODING_UTF16_BIG_ENDIAN = 'Unicode Big Endian';

  NODE_LEXER_ROOT = 'Highlighter';
  NODE_LEXER_DESC = 'desc';
  NODE_LEXER_ATTRIBUTE = 'attr';
  NODE_LEXER_KEYWORD = 'Keywords';
  NODE_LEXER_TYPE = 'type';
  NODE_EDITOR_ROOT = 'Editor';

implementation

end.

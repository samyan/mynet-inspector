Unit GlobalConstant;

Interface

Type
  TGlobalConstant = Class
  Public Const
    ALERT_MESSAGE_TITLE = 'Alert';
    INFO_MESSAGE_TITLE = 'Information';

    CLOSE_MESSAGE = 'Can''t close the connection!';
    KILL_MESSAGE = 'Can''t kill the process!';
    VIRUS_TOTAL_API_ERROR = 'No VirusTotal API Key defined!';

    INI_FILE_NAME = 'MyNetInspector.ini';
    INI_NAME_GENERAL = 'General';
    INI_VT_KEY_NAME = 'VirusTotalAPI';
    INI_DEFAULT_VALUE = 'Error';
    INI_RESTART_APP_MESSAGE = 'Please restart the application';
  End;

Implementation

End.

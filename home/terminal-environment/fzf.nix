{
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'bat -n --color=always --paging=never -r :\\$FZF_PREVIEW_LINES {}'" ];
    defaultOptions = [ "--height 40%" "--min-height 10" ];
  };
}

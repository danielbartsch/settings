{View, TextEditorView} = require 'atom-space-pen-views'

module.exports =
class GitChangeMarkerToolbar extends View
  @content: (params) ->
    @div class: 'git-change-marker-toolbar', =>
      @button class: 'btn icon icon-mail-reply height100', title: 'Rollback',  click: 'onRevert'
      @subview 'diffView', new TextEditorView

  initialize: (params) ->
    @onPreviousChange = params.onPreviousChange
    @onNextChange = params.onNextChange
    @onRevert = params.onRevert
    @onCopy = params.onCopy

    @diffView[0].style.display = 'flex';
    @diffView[0].style.alignItems = 'strech'
    @diffView[0].getModel().setGrammar params.editor.getGrammar()

    git.getLineDiff params.editor.getPath(), params.editor.getText(), params.line
    .then (diff) =>
      @diffView[0].getModel().setText(diff.oldContent)

  # show TextEditorView
  onCompare: (e) ->
    e.stopPropagation()
    if @diffView[0].style.display is 'none'
        @diffView[0].style.display = 'flex'
        @diffView[0].style.alignItems = 'strech'
    else
        @diffView[0].style.display = 'none'

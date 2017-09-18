{CompositeDisposable} = require 'atom'

module.exports =
  config:
    displayPrefix:
      type: 'string'
      default: ''
    displaySuffix:
      type: 'string'
      default: ''

  consumeStatusBar: (statusBar) ->
    @observeEditors()
    CursorIndicatorView = require './cursor-indicator-view'
    @view = new CursorIndicatorView()
    @view.initialize()
    @tile = statusBar.addLeftTile
      item: @view
      priority: 10

  deactivate: ->
    @osberver?.dispose()
    @observer = null
    @view?.destroy()
    @view = null
    @tile?.destroy()
    @tile = null

  observeEditors: ->
    @observer = atom.workspace.observeTextEditors (editor) =>
      disposables = new CompositeDisposable
      disposables.add editor.onDidRemoveCursor => @view?.update editor
      disposables.add editor.observeCursors => @view?.update editor
      editor.onDidDestroy -> disposables.dispose()

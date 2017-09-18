{CompositeDisposable} = require 'atom'

class CursorIndicatorView extends HTMLElement
  displayPrefix: ''
  subs: null
  displaySuffix: ''

  initialize: ->
    @classList.add 'inline-block'
    @classList.add 'cursor-indicator'
    @updateConfig()
    @handleEvents()
    @update()

  destroy: ->
    @subs?.dispose()
    @subs = null

  updateConfig: ->
    @displayPrefix = atom.config.get 'cursor-indicator.displayPrefix'
    @displaySuffix = atom.config.get 'cursor-indicator.displaySuffix'

  update: (editor) ->
    len = editor?.getCursors().length
    if len > 1
      @textContent = "#{@displayPrefix}#{len}#{@displaySuffix}"
      @style.display = 'inline-block'
    else
      @textContent = ''
      @style.display = 'none'

  handleEvents: ->
    @subs = new CompositeDisposable
    redraw = =>
      @updateConfig()
      @update()
    @subs.add atom.config.onDidChange 'cursor-indicator.displayPrefix', redraw
    @subs.add atom.config.onDidChange 'cursor-indicator.displaySuffix', redraw
    @subs.add atom.workspace.onDidChangeActivePaneItem (item) =>
      # Ensure the active pane actually supports cursors.
      return unless item and 'getCursors' of item

      # setTimeout required here otherwise the editor's cursors array
      # will not yet have been updated when we execute @update().
      setTimeout (=> @update item), 0

module.exports = CursorIndicatorView =
  document.registerElement 'cursor-indicator-view',
    prototype: CursorIndicatorView.prototype

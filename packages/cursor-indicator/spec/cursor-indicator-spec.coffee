describe 'CursorIndicator', ->
  [CursorIndicator, workspaceElement, statusBar, statusBarService, activeEditor] = []

  beforeEach ->
    workspaceElement = atom.views.getView atom.workspace
    jasmine.attachToDOM(workspaceElement)
    waitsForPromise ->
      atom.packages.activatePackage('status-bar').then (pack) ->
        statusBar = workspaceElement.querySelector 'status-bar'
        statusBarService = pack.mainModule.provideStatusBar()
    waitsForPromise ->
      atom.packages.activatePackage('cursor-indicator').then (pack) ->
        CursorIndicator = pack.mainModule
        CursorIndicator.consumeStatusBar statusBar
    waitsForPromise ->
      atom.workspace.open('test.txt').then (editor) ->
        activeEditor = editor
        activeEditor.setCursorBufferPosition [0, 0]

  describe 'after initialization', ->
    it 'tile is in the status bar', ->
      expect(CursorIndicator.tile).toBeDefined()
      expect(CursorIndicator.view).toBeDefined()
      expect(activeEditor).toBeDefined()

  describe 'when cursors are added', ->
    it 'shows cursor indicator', ->
      activeEditor.addCursorAtBufferPosition [1, 0]
      expect(CursorIndicator.view.textContent).toEqual '2'
      activeEditor.addCursorAtBufferPosition [2, 0]
      expect(CursorIndicator.view.textContent).toEqual '3'
      activeEditor.selectAll()
      expect(CursorIndicator.view.textContent).toEqual ''

  describe 'deactivate', ->
    it 'removes the tile', ->
      expect(CursorIndicator.tile).toBeDefined()
      atom.packages.deactivatePackage 'cursor-indicator'
      expect(CursorIndicator.tile).toBeNull()

    it 'can be executed twice', ->
      atom.packages.deactivatePackage 'cursor-indicator'
      atom.packages.deactivatePackage 'cursor-indicator'

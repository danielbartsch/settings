"use babel";

export default class GitStatusView {
  constructor(project) {
    this.element = document.createElement("div");
    this.element.id = "package-git-status";
    this.element.tabIndex = -1;
  }

  serialize() {}

  destroy() {
    this.element.remove();
  }

  getElement() {
    return this.element;
  }

  empty () {
    while (this.element.firstChild) {
      this.element.removeChild(this.element.firstChild);
    }
  }

  renderRepoNotFound () {
    this.empty();

    let notFoundNode = document.createElement("div");
    notFoundNode.classList.add("git-status-empty");
    notFoundNode.textContent = "couldn't found any repository in current project";
    this.element.appendChild(notFoundNode);
  }

  renderEmpty () {
    this.empty();

    let emptyNode = document.createElement("div");
    emptyNode.classList.add("git-status-empty");
    emptyNode.textContent = "nothing to commit, working directory clean";
    this.element.appendChild(emptyNode);
  }

  groupBy(xs, key) {
    return xs.reduce(function(rv, x) {
      (rv[x[key]] = rv[x[key]] || []).push(x);
      return rv;
    }, {});
  }

  renderList(list) {
    this.empty();
    const groupedList = this.groupBy(list, 'status')
    console.log('groupedList', groupedList);
    const sortedList = (groupedList['A '] || []).concat((groupedList['AD'] || []),
        (groupedList['MD'] || []),
        (groupedList[' D'] || []),
        (groupedList['D '] || []),
        (groupedList['AM'] || []),
        (groupedList['MM'] || []),
        (groupedList['M '] || []),
        (groupedList[' M'] || []),
        (groupedList['??'] || [])
    )
    console.log('sortedList', sortedList);
    sortedList.forEach(({ path, status }) => {
      let itemNode = document.createElement("div");
      let pathNode = document.createElement("div");
      let modifierClass;
      let pathSplit = path.split('/')
      let fileName = pathSplit[pathSplit.length - 1]
      switch (status) {
        case "??":
          modifierClass = "untracked";
          break;
        case "A ":
          modifierClass = "added";
          break;
        case "AD":
          modifierClass = "addedDeleted"
          break
        case "MD":
          modifierClass = "modifiedDeleted"
          break
        case " D":
        case "D ":
          modifierClass = "deleted";
          break;
        case "AM":
          modifierClass = "addedModified"
          break
        case "MM":
          modifierClass = "doubleModified"
          break
        case "M ":
        case " M":
          modifierClass = "modified";
          break;
        default:
          modifierClass = "unknown";
      }

      itemNode.classList.add("git-status-item");
      itemNode.classList.add(modifierClass);
      if (modifierClass !== "deleted") {
        itemNode.addEventListener("click", () => {
          atom.workspace.open(`${path}`, {});
        });
      }
      itemNode.textContent = `[${status}] ${fileName}`;
      pathNode.classList.add("path")
      pathNode.textContent = path.replace(fileName, '')
      itemNode.appendChild(pathNode)
      this.element.appendChild(itemNode);
    });
  }
}

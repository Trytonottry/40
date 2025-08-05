import tree_sitter, tree_sitter_python as tspython, tree_sitter_javascript as tsjs
from pathlib import Path

LANGS = {
    ".py": tree_sitter.Language(tspython.language(), "python"),
    ".js": tree_sitter.Language(tsjs.language(), "javascript"),
}

def analyze_repo(root: str, cves):
    parser = tree_sitter.Parser()
    calls = set()
    for path in Path(root).rglob("*.py"):
        parser.language = LANGS[".py"]
        tree = parser.parse(path.read_bytes())
        calls.update(extract_calls(tree))
    # аналогично для .js
    return calls

def extract_calls(tree):
    query = tree_sitter.Query(tree.language, "(call function: (identifier) @fn)")
    captures = query.captures(tree.root_node)
    return {c[0].text.decode() for c in captures}
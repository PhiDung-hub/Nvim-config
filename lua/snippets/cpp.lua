local status, ls = pcall(require, "luasnip")
if not status then
  return
end

local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local m = extras.m
local l = extras.l
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

-- template for insert_node
local function tI(args, parents)
  return args[1][1]
end

ls.add_snippets("cpp", {
  s({ trig = "starter", keyword = "starter", dcsr = "Code snippet for cpp starting template" }, {
    t({
      "#include <bits/stdc++.h>",
      "#include <stdexcept>",
      "#include <memory>",
      "",
      "using ll = long long;",
      "using namespace std;",
      "",
      "int main() {",
      "\t",
    }),
    i(0),
    t({ "", "\treturn 0;", "}" }),
  }),

  -- Input and output
  s({ trig = "cout", keyword = "std cout", dcsr = "Code snippet for printing to std::cout" }, {
    t("std::cout << "),
    i(1),
    t({ ";" }),
    i(0),
  }),

  s({
    trig = "coutl",
    keyword = "std cout with endl",
    dcsr = "Code snippet for printing to std::cout, with endl involved",
  }, {
    t("std::cout << "),
    i(1),
    t({ " << std::endl;" }),
    i(0),
  }),

  s({ trig = "cin", keyword = "std cin", dcsr = "Code snippet for std::cin, provided the header is set" }, {
    t("std::cin >> "),
    i(1),
    t({ ";" }),
    i(0),
  }),

  -- Control flow
  s({ trig = "for", keyword = "for loop", dcsr = "Code snippet for 'for' loop" }, {
    t("for ("),
    i(1, "size_t"),
    t(" "),
    i(2, "i"),
    t("="),
    i(3, "0"),
    t("; "),
    f(tI, { 2 }),
    t("<"),
    i(4, "n"),
    t("; "),
    f(tI, { 2 }),
    t({ "++) {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
  s({ trig = "forr", keyword = "reverse for loop", dcsr = "Code snippet for reverse 'for' loop" }, {
    t("for ("),
    i(1, "size_t"),
    t(" "),
    i(2, "i"),
    t("="),
    i(3, "n"),
    t("; "),
    f(tI, { 2 }),
    t(">="),
    i(4, "0"),
    t("; "),
    f(tI, { 2 }),
    t({ "--) {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
  s({ trig = "fora", keyword = "for loop", dcsr = "Code snippet for auto 'for' loop" }, {
    t("for (auto "),
    i(1, "x"),
    t(" : "),
    i(2, "container"),
    t({ ") {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
  s({ trig = "forit", keyword = "iterator for loop", dcsr = "Code snippet for iterator 'for' loop" }, {
    t("for (auto& "),
    i(1, "it"),
    t("="),
    i(2, "container"),
    t(".begin(); "),
    f(tI, { 1 }),
    t("!="),
    f(tI, { 2 }),
    t(".end(); "),
    f(tI, { 1 }),
    t({ "++) {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
  s({ trig = "while", keyword = "while loop", dcsr = "Code snippet for 'while' loop" }, {
    t("while ("),
    i(1),
    t({ ") {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
  s({ trig = "dowhile", keyword = "do while loop", dcsr = "Code snippet for 'do while' loop" }, {
    t({ "do {", "\t" }),
    i(1),
    t({ "", "} " }),
    t("while ("),
    i(0),
    t(");"),
  }),

  -- Vector
  s({ trig = "vec", regTrig = true, name = "vector", dcsr = "Basic vector" }, {
    t("std::vector<"),
    i(1, "int"),
    t("> "),
    i(2, "vec"),
    t({ ";" }),
    i(0),
  }),
  s({ trig = "vecn", regTrig = true, name = "vectorn", dcsr = "Vector of size n" }, {
    t("std::vector<"),
    i(1, "int"),
    t("> "),
    i(2, "vec"),
    t("("),
    i(3, "n"),
    t(", "),
    i(3, "0"),
    t({ ");" }),
    i(0),
  }),
  s({ trig = "vi", regTrig = true, name = "vector", dcsr = "Basic vector" }, {
    t("std::vector<"),
    i(1, "int"),
    t("> "),
    i(0),
  }),
  s({ trig = "vii", regTrig = true, name = "vector", dcsr = "Basic vector" }, {
    t("std::vector<"),
    i(1, "std::pair<int, int>"),
    t("> "),
    i(0),
  }),

  -- List
  s({ trig = "dll", regTrig = true, name = "dll", dcsr = "Doubly linkedlist" }, {
    t("std::list<"),
    i(1, "int"),
    t("> "),
    i(2, "dll"),
    t({ ";" }),
    i(0),
  }),
  s({ trig = "ll", regTrig = true, name = "ll", dcsr = "Singly linkedlist" }, {
    t("std::forward_list<"),
    i(1, "int"),
    t("> "),
    i(2, "ll"),
    t({ ";" }),
    i(0),
  }),
  s({ trig = "list", regTrig = true, name = "list", dcsr = "Doubly linkedlist" }, {
    t("std::list<"),
    i(1, "int"),
    t("> "),
  }),
  s({ trig = "flist", regTrig = true, name = "forward list", dcsr = "Singly linkedlist" }, {
    t("std::forward_list<"),
    i(1, "int"),
    t("> "),
  }),

  s({ trig = "vecn", regTrig = true, name = "vectorn", dcsr = "Vector of size n" }, {
    t("std::vector<"),
    i(1, "int"),
    t("> "),
    i(2, "vec"),
    t("("),
    i(3, "n"),
    t(", "),
    i(3, "0"),
    t({ ");" }),
    i(0),
  }),

  -- Stack & queue & priority queue
  s({ trig = "stk", name = "stack", dcsr = "Basic stack" }, {
    t("std::stack<"),
    i(1, "int"),
    t("> "),
    i(2, "stk"),
    t({ ";" }),
    i(0),
  }),
  s({ trig = "que", name = "queue", dcsr = "Basic queue" }, {
    t("std::queue<"),
    i(1, "int"),
    t("> "),
    i(2, "q"),
    t({ ";" }),
    i(0),
  }),
  s({ trig = "pq", name = "priority queue", dcsr = "Basic priority queue" }, {
    t("std::queue<"),
    i(1, "int"),
    t("> "),
    i(2, "pq"),
    t({ ";" }),
    i(0),
  }),
  s({ trig = "pqii", name = "priority queue", dcsr = "Priority queue of pair int int" }, {
    t({
      "auto cmp = [](auto a, auto b) { return a.first > b.first; };",
      "std::priority_queue<pair<int, int>, std::vector<pair<int, int>>, decltype(cmp)> pq(cmp);",
    }),
  }),
  s({ trig = "pqic", name = "priority queue pair int char", dcsr = "Priority queue of pair int char" }, {
    t({
      "auto cmp = [](auto a, auto b) { return a.first > b.first; };",
      "std::priority_queue<pair<int, char>, std::vector<pair<int, char>>, decltype(cmp)> pq(cmp);",
    }),
  }),
  s({ trig = "pqis", name = "priority queue", dcsr = "Priority queue of int string" }, {
    t({
      "auto cmp = [](auto a, auto b) { return a.first > b.first; };",
      "std::priority_queue<pair<int, string>, std::vector<pair<int, string>>, decltype(cmp)> pq(cmp);",
    }),
  }),

  -- map and set
  s({ trig = "mp", name = "generic map", dcsr = "Hash map" }, {
    t("std::unordered_map<"),
    i(1, "int"),
    t(", "),
    i(2, "int"),
    t("> "),
    i(3, "mp"),
    t(";"),
    i(0),
  }),
  s({ trig = "imp", name = "iterator for generic map", dcsr = "Hash map iterator" }, {
    t("std::unordered_map<"),
    i(1, "int"),
    t(", "),
    i(2, "int"),
    t(">::iterator "),
    i(3, "imp"),
    t(";"),
    i(0),
  }),
  s({ trig = "mpii", name = "map int int", dcsr = "Hash map of int int" }, {
    t("std::unordered_map<int, int> "),
    i(1, "mp"),
    t(";"),
    i(0),
  }),
  s({ trig = "mpis", name = "map int string", dcsr = "Hash map of int string" }, {
    t("std::unordered_map<int, std::string> "),
    i(1, "mp"),
    t(";"),
    i(0),
  }),
  s({ trig = "mpsi", name = "map string int", dcsr = "Hash map of string int" }, {
    t("std::unordered_map<std::string, int> "),
    i(1, "mp"),
    t(";"),
    i(0),
  }),
  s({ trig = "mpss", name = "map string string", dcsr = "Hash map of string string" }, {
    t("std::unordered_map<std::string, std::string> "),
    i(1, "mp"),
    t(";"),
    i(0),
  }),

  -- Pair
  s({ trig = "pii", name = "pair int int", dscr = "Basic pair" }, {
    t("std::pair<int, int>"),
  }),
  s({ trig = "puu", name = "pair size_t size_t", dscr = "Basic pair" }, {
    t("std::pair<size_t, size_t>"),
  }),
  s({ trig = "pis", name = "pair int strig", dscr = "Basic pair" }, {
    t("std::pair<int, string>"),
  }),
  s({ trig = "psi", name = "pair string int", dscr = "Basic pair" }, {
    t("std::pair<string, int>"),
  }),
  s({ trig = "pss", name = "pair string string", dscr = "Basic pair" }, {
    t("std::pair<string, string>"),
  }),

  -- sort container
  s({ trig = "sort", name = "sort containter", dscr = "Sort container" }, {
    t({ "auto cmp = [](auto a, auto b) { return a < b; };", "std::sort(" }),
    i(1, "vec"),
    t(".begin(), "),
    f(tI, { 1 }),
    t({ ".end(), cmp);", "" }),
    i(0),
  }),
  s({ trig = "sortp", name = "sort containter of pairs", dscr = "Sort pairs container" }, {
    t({ "auto cmp = [](auto a, auto b) { return a.first < b.first; };", "std::sort(" }),
    i(1, "vec"),
    t(".begin(), "),
    f(tI, { 1 }),
    t({ ".end(), cmp);", "" }),
    i(0),
  }),

  -- string utils
  s({ trig = "ss", name = "stringstream" }, {
    t('const string& str="'),
    i(1),
    t({ '";', "std::stringstream ss(str);" }),
    i(0),
  }),
  s({
    trig = "str_splitter",
    regTrig = true,
    name = "string splitter",
    dscr = "Split string into words with delimeters",
  }, {
    t({
      "std::vector<string> splitStr(const string& target_string, const char delimeter=' ') { std::vector<string> words;size_t string_len = target_string.length();size_t start_word=0;size_t word_size=0;for (size_t i = 0; i < string_len; i++) {if(target_string[i] == delimeter) {word_size = i-start_word;words.push_back(target_string.substr(start_word, word_size));start_word = i+1;}}int last_word_size = string_len-start_word;string last_word = target_string.substr(start_word, last_word_size);words.push_back(last_word); return words;}",
    }),
  }),
  s({
    trig = "get_word",
    regTrig = true,
    name = "get word in a line",
    dscr = "Split string into words with delimeters using ss",
  }, {
    t({
      '  const string &str = "This,is,a,word,string"; std::stringstream ss(str); string word; while (getline(ss, word, \',\')) { std::cout << word << " - "; }',
    }),
  }),

  -- Tree
  s({ trig = "tree", name = "starter binary tree", dscr = "Starter code for basic cpp binary tree" }, {
    t({ "struct TreeNode {", "\t" }),
    i(1, "int"),
    t({ " val;", "" }),
    t({ "\tTreeNode *left;", "\tTreeNode *right;" }),
    t("\tTreeNode(): val("),
    i(2, "0"),
    t({ "), left{nullptr}, right{nullptr} {}", "" }),
    t("\tTreeNode("),
    f(tI, 1),
    t({ " x) : val(x), left{nullptr}, right{nullptr} {}", "" }),
    t({ "\tTreeNode(" }),
    f(tI, 1),
    t({ " x, TreeNode *left, TreeNode *right): val(x), left{left}, right{right} {}", "};", "" }),
  }),
  s({ trig = "ptree", name = "print tree", dscr = "print the binary tree" }, {
    t(
      'void printTree(TreeNode *root, const std::string& prefix="", bool isLeft=false) { if(root) { std::cout << prefix; std::cout << (isLeft ? "├──" : "└──"); std::cout << root->val << std::endl; printTree(root->left,prefix + (isLeft?"│  ": "   "), true); printTree(root->right,prefix + (isLeft?"│  ": "   "), false); } }'
    ),
  }),

  -- Graph
  s({ trig = "dugraph", name = "directed unweighted graph", dscr = "" }, {
    t({
      "struct Edge {",
      "\tint from;",
      "\tint to;",
      "};",
      "",
      "struct DUGraph {",
      "\tll E;",
      "\tint V;",
      "\tstd::vector<std::vector<int>> graph;",
      "",
      'void insertEdge(const int from, const int to) { if (from > this->V || to > this->V) { std::ostringstream ss; ss << "Vertex from=" << from << ", to=" << to << " are out of range V=" << V << std::endl; throw std::out_of_range(ss.str()); } this->graph[from].push_back({to}); this->E += 1; } void removeEdge(const int from, const int to) { if (from > this->V || to > this->V) { std::ostringstream ss; ss << "Vertex from=" << from << ", to=" << to << " are out of range V=" << V << std::endl; throw std::out_of_range(ss.str()); } auto edgeList = this->graph[from]; edgeList.erase(std::next(edgeList.begin(), to)); this->V -= 1; } DUGraph(int V, const std::vector<Edge> &edges) : V(V), graph(V) { for (auto edge : edges) { this->insertEdge(edge.from, edge.to); } } void getInfo() { std::cout << "Vertex: " << this->V << std::endl; std::cout << "Edge: " << this->E << std::endl; for (int i = 0; i < V; i++) { auto &edgeList = graph[i]; for (auto edge : edgeList) { std::cout << i << \'-\' << edge << std::endl; } } } };',
    }),
  }),
  s({ trig = "dwgraph", name = "directed weighted graph", dscr = "" }, {
    t({
      "struct Edge {",
      "\tint from;",
      "\tint to;",
      "\tint weight;",
      "};",
      "",
      "struct DWGraph {",
      "\tll E;",
      "\tint V;",
      "\tstd::vector<std::vector<pair<int, int>>> graph;",
      "",
      'void insertEdge(const int from, const int to, const int weight = 1) { if (from > this->V || to > this->V) { std::ostringstream ss; ss << "Vertex from=" << from << ", to=" << to << " are out of range V=" << V << std::endl; throw std::out_of_range(ss.str()); } this->graph[from].push_back({to, weight}); this->E += 1; } void removeEdge(const int from, const int to) { if (from > this->V || to > this->V) { std::ostringstream ss; ss << "Vertex from=" << from << ", to=" << to << " are out of range V=" << V << std::endl; throw std::out_of_range(ss.str()); } auto edgeList = this->graph[from]; edgeList.erase(std::next(edgeList.begin(), to)); this->V -= 1; } DWGraph(int V, const std::vector<Edge> &edges) : V(V), graph(V) { for (auto edge : edges) { this->insertEdge(edge.from, edge.to, edge.weight); } } void getInfo() { std::cout << "Vertex: " << this->V << std::endl; std::cout << "Edge: " << this->E << std::endl; for (int i = 0; i < V; i++) { auto &edgeList = graph[i]; for (auto edge : edgeList) { std::cout << i << \'-\' << edge.first << ": " << edge.second << std::endl; } } } };',
    }),
  }),
  s({
    trig = "dijkstra",
    name = "dijkstra algorithm",
    dcsr = "Dijkstra algorithm on directed weighted graph, graph edges should be positive",
  }, {
    t({
      "std::vector<pair<int, int>> Dijkstra(int source) {",
      "\tstd::vector<pair<int, int>> resultTree(this->V, {-1, INT_MAX});",
      "\tstd::vector<bool> visited(this->V, false);",
      "\t",
      "\tresultTree[source] = {-1, 0};",
      "\tvisited[source] = true;",
      "\t",
      "\tauto cmp = [](auto a, auto b) { return a.second > b.second; };",
      "\tstd::priority_queue<pair<int, int>, std::vector<pair<int, int>>, decltype(cmp)> pq(cmp);",
      "\tpq.push({0, 0});",
      "\t",
      "\twhile (!pq.empty()) {",
      "\t  auto u = pq.top();",
      "\t  pq.pop();",
      "\t  int thisEdge{u.first}, curDistance{u.second};",
      "\t  visited[thisEdge] = true;",
      "\t  for (auto neighbor : this->graph[thisEdge]) {",
      "\t    int vertex{neighbor.first}, weight{neighbor.second};",
      "\t    if (!visited[vertex] && resultTree[vertex].second > curDistance + weight) {",
      "\t      int optimalDist = curDistance + weight;",
      "\t      pq.push({vertex, optimalDist});",
      "\t      resultTree[vertex] = {thisEdge, optimalDist};",
      "\t    }",
      "\t  }",
      "\t}",
      "\t",
      "\treturn resultTree;",
      "}",
    }),
  }),

  -- String function
  s({
    trig = "in2post",
    regTrig = true,
    name = "infix to postfix",
    dscr = "Convert an infix expression to postfix expression",
  }, {
    t(
      "string infixToPostfix(const string& input) { string output; std::stack<char> stk; auto precedence = [](char op) -> int { switch (op) { case '*': case '/': return 1; default: return 0; } }; bool continous_parenthesis = false; for (char c : input) { switch (c) { case '*': case '/': case '+': case '-': while (!stk.empty() && stk.top() != '(' && precedence(stk.top()) >= precedence(c)) { output.push_back(' '); output.push_back(stk.top()); continous_parenthesis = false; stk.pop(); } output.push_back(' '); stk.push(c); break; case '(': stk.push(c); break; case ')': if (!continous_parenthesis) { output.push_back(' '); } while (!stk.empty()) { if (stk.top() != '(') { output.push_back(stk.top()); continous_parenthesis = false; stk.pop(); } else { continous_parenthesis = true; stk.pop(); break; } } break; case ' ': break; default: output.push_back(c); continous_parenthesis = false; } } while (!stk.empty()) { output.push_back(' '); output.push_back(stk.top()); stk.pop(); } return output; }"
    ),
  }),

  s({ trig = "rabin_karp", regTrig = true, name = "Rabin-Karp", dscr = "Rabin Karp string finder algo" }, {
    t("rabin karp"),
  }),

  -- quick sort.
  s({ trig = "partition" }, {
    t(
      "int partition(std::vector<int>& v, int l, int r) { int p{l}, $pivot = v[l]; for (int i=l+1; i<=r; i++) { if(v[i] < $pivot) { std::swap(v[p+1], v[i]); p++; }   } std::swap(v[l], v[p]); return p; }"
    ),
  }),
  s({ trig = "partition3" }, {
    t(
      "pair<int, int> partition3(std::vector<int> &v, int l, int r) { int p{l}, $pivot = v[l]; int start=l+1, end=r; while(start<=end) { if (v[start] < $pivot) { std::swap(v[p+1], v[start]); p++; } else if (v[start] > $pivot) { std::swap(v[start--], v[end--]); } start++; } std::swap(v[l], v[p]); pair<int, int> partition{p, end}; return partition; }"
    ),
  }),
  s({ trig = "qsort" }, {
    t(
      "void quickSort(std::vector<int> &v, int l, int r) { if(l >= r) return; int k = l + std::rand() % (r-l+1); std::swap(v[l], v[k]); int p = partition(v, l, r); quickSort(v, l, p-1); quickSort(v, p+1, r); }"
    ),
  }),
})

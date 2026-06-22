
####################### web search #################

__web_search() {
  emulate -L zsh

  # define search engine URLS
  typeset -A urls
  urls=(
    $ZSH_WEB_SEARCH_ENGINES
    bili            "https://search.bilibili.com/all?keyword="
    google          "https://www.google.com/search?q="
    bing            "https://www.bing.com/search?q="
    brave           "https://search.brave.com/search?q="
    yahoo           "https://search.yahoo.com/search?p="
    duckduckgo      "https://www.duckduckgo.com/?q="
    startpage       "https://www.startpage.com/do/search?q="
    yandex          "https://yandex.ru/yandsearch?text="
    github          "https://github.com/search?q="
    baidu           "https://www.baidu.com/s?wd="
    ecosia          "https://www.ecosia.org/search?q="
    goodreads       "https://www.goodreads.com/search?q="
    qwant           "https://www.qwant.com/?q="
    givero          "https://www.givero.com/search?q="
    stackoverflow   "https://stackoverflow.com/search?q="
    wolframalpha    "https://www.wolframalpha.com/input/?i="
    archive         "https://web.archive.org/web/*/"
    scholar         "https://scholar.google.com/scholar?q="
    ask             "https://www.ask.com/web?q="
    youtube         "https://www.youtube.com/results?search_query="
    deepl           "https://www.deepl.com/translator#auto/auto/"
    dockerhub       "https://hub.docker.com/search?q="
    gems            "https://rubygems.org/search?query="
    npmpkg          "https://www.npmjs.com/search?q="
    packagist       "https://packagist.org/?query="
    gopkg           "https://pkg.go.dev/search?m=package&q="
    chatgpt         "https://chatgpt.com/?q="
    grok            "https://grok.com/?q="
    claudeai        "https://claude.ai/new?q="
    reddit          "https://www.reddit.com/search/?q="
    ppai            "https://www.perplexity.ai/search/new?q="
    rscrate         "https://crates.io/search?q="
    rsdoc           "https://docs.rs/releases/search?query="
  )

  # Construct final URL (if query exists, URL encode it)
  query="${(@j: + :)${(@)argv[2,-1]}}"
  [[ -n "$query" ]] && query=$(omz_urlencode "$query")

  # Build URL using the selected search engine
  url="${urls[$1]}$query"
  echo "$url"
  /usr/bin/firefox "$url"
}

omz_urlencode() {
  # 使用 perl 进行 URL 编码，并确保空格转为 %20 而不是 +
  echo -n "$1" | perl -MURI::Escape -e 'print uri_escape(<STDIN>);'
}

# Automatically generate aliases for all search engines in `urls`
for engine in ${(k)urls}; do
  alias "$engine"="__web_search $engine"
done
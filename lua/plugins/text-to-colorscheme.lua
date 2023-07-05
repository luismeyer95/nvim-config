return {
  "svermeulen/text-to-colorscheme",
  cmd = "T2CGenerate",
  opts = {
    ai = {
      openai_api_key = os.getenv("OPENAI_API_KEY"),
    }
  }
}

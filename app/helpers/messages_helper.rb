module MessagesHelper

  # Returns HTML from input text using Markdown
  def markdown_to_html(text)
    Kramdown::Document.new(text).to_html
  end
end

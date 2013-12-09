def markdown(text)
  renderer = PygmentizeHTML
  options = {
    :hard_wrap => true,
    :autolink => true,
    :no_intra_emphasis => true,
    :fenced_code => true,
    :prettify => true,
    :fenced_code_blocks => true,
    :lax_spacing => true,
    :gh_blockcode => true,
    :disable_indented_code_blocks => false,
    :tables => true
  }
  Redcarpet::Markdown.new(renderer, options).render(text).html_safe
end

class PygmentizeHTML < Redcarpet::Render::HTML
  def block_code(code, language)
    require 'pygmentize'
    language ||= "text"
    Pygmentize.process(code, language)
  end
end

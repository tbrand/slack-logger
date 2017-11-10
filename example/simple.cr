require "../src/slack-logger"

class Simple
  def initialize
    set_default_webhook("https://hooks.slack.com/services/T68D3NLER/B7XHCSEN6/DFpv7f1DzPYDkg1txxxxxxxx")
  end

  def out
    info "test"
    impt "come here"
    error "error"

    sleep 1
  end

  include SlackLogger
end

simple = Simple.new
simple.out

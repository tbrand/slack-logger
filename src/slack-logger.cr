require "http/client"
require "json"
require "./slack-logger/*"

module SlackLogger
  def set_default_webhook(@slack_webhook_url : String?)
  end

  def info(msg : String, post_slack = false)
    log_out(green("Info"), msg)
    post_slack(msg) if post_slack
  end

  def error(msg : String, post_slack = true)
    log_out(red("Erro"), msg)
    post_slack(msg) if post_slack
  end

  def warn(msg : String, post_slack = false)
    log_out(yellow("Warn"), msg)
    post_slack(msg) if post_slack
  end

  def impt(msg : String, post_slack = true)
    log_out(magenta("Impt"), msg)
    post_slack(msg) if post_slack
  end

  def test(msg : String)
    log_out(cyan("Test"), msg)
  end

  def log_out(tag, msg)
    puts "[#{ftime}]: [#{tag}] #{msg}"
  end

  def ftime : String
    Time.now.to_s("%Y-%m-%d %H:%M:%S")
  end

  def post_slack(msg : String, _slack_webhook_url : String? = @slack_webhook_url)
    payload = { text: without_colors(msg) }.to_json
    post_slack_for_payload(payload, _slack_webhook_url)
  end

  def post_slack_for_payload(payload : String, _slack_webhook_url : String?)
    spawn do
      if slack_webhook_url = _slack_webhook_url
        headers = HTTP::Headers.new
        headers["Content-type"] = "application/json"
        HTTP::Client.post(slack_webhook_url, headers: headers, body: payload)
      end
    end
  end

  def without_colors(text)
    text.gsub(/\e\[(\d+)m/, "")
  end

  include Color
end

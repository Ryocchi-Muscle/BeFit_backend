# lib/tasks/generate_api_token.rake
namespace :app do
  desc "Generate a new API token"
  task generate_api_token: :environment do
    token = SecureRandom.hex(20)
    puts "Generated API token: #{token}"
    # ここでトークンを環境変数にセットしたり、アプリケーションの設定ファイルに保存する処理を追加する
  end
end

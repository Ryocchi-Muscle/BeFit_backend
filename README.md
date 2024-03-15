## ■サービス概要
駆け出しトレニー（筋トレをしている人のこと）の情報共有メディアサービスです。


## ■ このサービスへの思い・作りたい理由
#### ・背景：多くの人にフィットネスの楽しさを伝えたい。

私は現在筋トレを始めて４年目になりますが、トレーニングを始めるまで自信が全くなく、消極的な性格でした。<br>
ところが、トレーニングを始めてから自信がつき、自尊心を持つことができるようになりました。<br>
また、大学時代に専攻していた「臨床心理学」と「筋トレ」を絡めたテーマに研究を行い、その結果、運動は身体だけでなく、心の健康維持に大きな影響を与えていることがわかりました。この体験を多くの人に知ってほいしと、まずは友人に筋トレを勧めました。<br>
しかしここでトレーニング初心者が抱えている問題があると感じました。それは、<br>
**「1人だとモチベーションの維持が困難」** ということです。<br>
何か新しい挑戦を行う際、1人で行うよりも仲間がいた方が持続しやすいというのは、明白です。<br>
何事もそうですが、結果が出るまでにはある一定のトレーニングが必要であり、私自身も1人で筋トレを開始したため、1年目はモチベーションがなく、挫折したこともありました。<br>
そんな人たちのために、駆け出しトレニーがオンラインでつながり合えるサービスを提供したいと思い、このサービスを開発しようと思いました。

## ■ ユーザー層について
#### 対象者：筋トレ初心者（駆け出しトレニー）

## ■サービスの利用イメージ
全くの筋トレ初心者でもジムに行き、なりたい体型になるためのトレーニングを知り、実践することができるようになります。<br>

## ■ ユーザーの獲得について
友人に試用してもらったり、<br>
Twitterやmattermost、Qitta等で宣伝し、ユーザー獲得を行う予定。<br>


## ■ サービスの差別化ポイント・推しポイント
ほかアプリとの差別化ポイント<br>
①食事とトレーニングを両方サポートしている。<br>
②トレーニング解説が記載されている。<br>
③YouTube動画を用いることによって、動画から正しいフォームを習得し、実践できる。<br>

## ■ 機能候補
第1段階（基本機能：10-15機能）<br>

ユーザー機能<br>

・新規ユーザー登録機能（メールアドレスとパスワードを用いた）<br>
・ログイン/ログアウト機能<br>
・ユーザー情報登録/表示/編集機能（名前、アイコン画像、プロフィール）<br>
・パスワード再設定機能<br>
・ゲストログイン<br>
・ユーザー情報の詳細ページ表示　※ログインなしでも可<br>

投稿機能<br>
・投稿作成/表示/削除/編集機能（文章、画像）<br>
・投稿一覧表示　　　　※ログインなしでも可<br>
・投稿詳細ページ表示　※ログインなしでも可<br>
・ページネーション機能<br>


トレーニング記録<br>

・トレーニング記録　作成/表示/編集/削除（メニュー、部位、記録）<br>

いいね・コメント機能<br>

・投稿への「いいね」<br>
・投稿へのコメント<br>
・コメントへの返信<br>


フォロー・フォロワー機能<br>
・ユーザーのフォロー/フォローアンフォロー<br>
・フォロワー一覧の表示　※ログインなしでも可<br>

ブックマーク機能<br>
・投稿をブックマーク<br>


第2段階（MVPに向けた拡張機能）<br>

ユーザー機能<br>
・ソーシャルログイン機能（Google）<br>
・目的設定機能（減量、維持、増量）<br>
・退会機能<br>

検索機能<br>
・投稿の検索<br>
・タグでの投稿検索<br>
・動画検索機能　　（YouTubeAPI）<br>
・タグでの動画検索（YouTubeAPI）<br>

ブックマーク機能<br>
・動画をブックマーク<br>

第3段階<br>

トレーニング記録・シェア機能<br>
・トレーニング記録の公開/非公開機能<br>
・twitterシェア機能<br>


■ 機能の実装方針予定<br>
一般的なCRUD以外の実装予定の機能についてそれぞれどのようなイメージ(使用するAPIや)で実装する予定なのか現状考えているもので良いので教えて下さい。<br>
・ブックマーク機能と検索機能を実装予定です。<br>
＜使用予定API＞<br>
・YouTubeAPI<br>
・chatGPT API<br>
ほかは、検討中です。<br>

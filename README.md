## ■サービス概要
「ジムに行っても、何をしていいかわからない〜」<br>
「とりあえず、ランニングマシンしとこ〜」<br>
そんな筋トレ初心者をサポートするアプリです！<br>


## ■ このサービスへの思い・作りたい理由
#### ・背景：多くの人にフィットネスの楽しさを伝えたい。

私は現在筋トレを始めて４年目になりますが、トレーニングを始めるまで自信が全くなく、消極的な性格でした。<br>
ところが、トレーニングを始めてから自信がつき、自尊心を持つことができるようになりました。<br>
また、大学時代に専攻していた「臨床心理学」と「筋トレ」を絡めたテーマに研究を行い、その結果、運動は身体だけでなく、心の健康維持に大きな影響を与えていることがわかりました。この体験を多くの人に知ってほいしと、まずは友人に筋トレを勧めました。<br>
しかしここでトレーニング初心者が抱えている問題があると感じました。それは、<br>
**「トレーニング方法や、体つくりの知識がなく、何を行えばいのかわからない** ということです。<br>
現在、トレーニングと食事管理が両立しているアプリは少ないため、トレーニングと食事の両方のサポートがあり、
正しく努力することで最短で結果を出すサポートができるこのアプリを作成しようと思いました。<br>

## ■ ユーザー層について
#### 対象者：筋トレ初心者（男女）

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
機能選定 MVP<br>
基本機能（第１段階）<br>
・ログイン/ログアウト機能<br>
・メールアドレスとパスワードを利用したユーザー登録<br>
・Google ログイン認証（のみにするか検討中）
(・外部APIを利用したユーザー登録 / ログイン機能/ログアウト機能)<br>
・ユーザー情報変更機能<br>

- ゲストログイン機能/ログアウト機能<br>
・退会機能<br>
・パスワード再設定機能<br>
・トレーニング記録機能<br>
　└選択項目<br>
　・部位<br>
　・xxx kg x y sets<br>


第２段階<br>
・部位別、トレーニングメニュー解説ページ表示機能<br>
　・胸<br>
　・背中<br>
　・肩<br>
　・腕<br>
　・脚<br>

・1日のトータルボリューム計算&表示機能<br>
・動画検索機（マルチ検索）<br>
自分のトレーニングしたい部位の動画をYouTubeからひっぱてくる。<br>

・ブックマーク機能<br>
　お気に入りの動画をブックマークし、ジムで見返しながら、正しいフォームを身につける<br>

・コース選択<br>
　・体重入力<br>
　・トレーニングの目的<br>
　　・減量（体重を減らす）<br>
　　・体重を維持する<br>
　　・増量（体重を増やす）<br>
　・トレーニングの経験<br>
　　・未経験<br>
　　・中級者<br>
　　・上級者<br>
　・１週間あたりのトレーニングの頻度<br>
　　・週2回〜週5回<br>

　・基礎代謝<br>
　　・低い（生活の大部分が座位、静的な生活が中心）<br>
　　・普通（座位の生活だが、通勤、買い物など、軽い運動は行っている）<br>
　　・高い（移動や立ち位中心の仕事を行っている）<br>
　・おすすめプランの提示<br>
　　・期間12週間<br>
　　・カウントダウン<br>
　　・その日行うトレーニングメニュー<br>


・部位別動画レコメンド機能（YouTubeAPI）<br>
　(胸・背中・肩・腕・脚・腹)<br>
※レコメンド機能については、個人的に余計かなと感じる面もあり、検討中です。<br>

・アニメーション機能<br>
　ex)ある程度の継続ができれば、アニメーション等でユーザーを褒める機能<br>
→　褒めることでユーザーの離脱を防ぎ、トレーニング継続を促す効果<br>

食事系<br>
・1日に必要なカロリー自動計算機能<br>
・食事記録機能<br>
　・食べたもの（食品）<br>
※外部APIから情報を取得<br>
　・食べた時間ごとに入力<br>
　　・朝・昼・夜・間食<br>

　　・カロリー（自動計算）<br>
　　・PFC（タンパク質、炭水化物、脂質）を入力する（自動計算）<br>
・筋トレにいい食材紹介ページ表示機能<br>
・食品レコメンド機能<br>
　・1日の目標カロリーを計算し、目標と実際のカロリー収支を比較<br>
（できれば、マイナスの場合、追加でとると良い食材を提案する機能を実装）<br>


高度な機能、本リリースまでに実装したい機能について現時点では、未検討です。<br>
基本機能を実装と工数を見ながら検討予定です。<br>


■ 機能の実装方針予定<br>
一般的なCRUD以外の実装予定の機能についてそれぞれどのようなイメージ(使用するAPIや)で実装する予定なのか現状考えているもので良いので教えて下さい。<br>

・YouTubeAPI<br>
・chatGPT API<br>
ほかは、検討中です。<br>

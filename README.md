# Flutter DevOps サンプル

このリポジトリは、2023年7月11日に開催された [Google I/O Extended Japan](https://developersonair.withgoogle.com/events/ioextendedjapan2023) で [Wasabeef](https://github.com/wasabeef) さんが発表した「Flutter の活用事例 / Live Q&A」を元に作ったサンプルコードです。

## 概要

<p align="center">
  <img src="https://github.com/Ryotaewamoto/flutter_DevOps_sample/blob/develop/figure_flutter_devops_sample.png?raw=true" alt="Flutter DevOps Sample" />
</p>

### Firebase Hosting によるデプロイ済みのアプリケーション
<p align="center">
  <img src="https://github.com/Ryotaewamoto/flutter_DevOps_sample/blob/develop/figure_device_preview.png?raw=true" alt="Flutter DevOps Sample" />
</p>

## 実装手順

1. コマンドによる Flutter アプリケーションの作成
2. GitHub のリポジトリを作成し、プッシュ
3. 必要な Flutter のパッケージを追加
4. Firebase の初期化
5. Firebase Hosting の設定
6. GitHub Actions の設定

## 事前準備

- [GitHub](https://github.co.jp/) のアカウントを作成
- [Flutter](https://flutter.dev/docs/get-started/install) のインストール
- [Firebase CLI](https://firebase.google.com/docs/cli) のインストール
- [fvm](https://fvm.app/) のインストール

## 1. コマンドによる Flutter アプリケーションの作成

以下のコマンドを作成したいディレクトリで実行します。``-e`` オプションで不要なコメントやサンプルコードを省いたテンプレートを使用できます。ドメインは個人で使用しているものをお使いください。

```
$ flutter create -e flutter-devops-sample \
  --org com.ryotaiwamoto \
  --project-name flutter_devops_sample \
  --platforms ios,android,web
```

## 2. GitHub のリポジトリを作成し、プッシュ

GitHub でリポジトリを作成し、ローカルのリポジトリにリモートリポジトリを追加します。そのために作成したアプリのディレクトリで下記を実行します。

```
$ echo "# flutter_DevOps_sample" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/Ryotaewamoto/flutter_DevOps_sample.git
git push -u origin main
```

## 3. 必要な Flutter のパッケージを追加

まず、Flutter のバージョン管理を行うために ``fvm`` を追加します。今回は ``3.10.0`` を使用します。

```
$ fvm use 3.10.0
```

次に、Firebase との連携を行うために ``firebase_core`` を、レビュー時にデバイスが Web 上で見れるようにするために ``device_preview`` を追加します。

```
$ fvm flutter pub add device_preview
$ fvm flutter pub add firebase_core
```

## 4. Firebase の初期化

Firebase との連携を行うために、Firebase のプロジェクトを作成します。基本的には、作成したプロジェクトの設定画面からアプリを追加し、アプリの追加時に表示されるコードを ``lib/main.dart`` に追加します。ですが、今回は ``flutterfire`` コマンドを使用して初期化を行います。こちらのドメイン名も個人で使用しているものをお使いください。

```
$ flutterfire configure \
  --out=lib/firebase_options.dart \
  --platforms=android,ios,web \
  --ios-bundle-id=com.ryotaiwamoto.flutterDevopsSample \
  --android-package-name=com.ryotaiwamoto.flutter_devops_sample
```

## 5. Firebase Hosting の設定

Firebase Hosting で Web アプリケーションを公開するために、Firebase Hosting を有効化します。 ``device_preview`` パッケージが含まれているため、ここで公開したアプリケーションはレビュー時に、 Web のデバイス上で確認することができます。下記を参考にコマンドの指示に従って進めてください。

```
$ firebase init hosting

     ######## #### ########  ######## ########     ###     ######  ########
     ##        ##  ##     ## ##       ##     ##  ##   ##  ##       ##
     ######    ##  ########  ######   ########  #########  ######  ######
     ##        ##  ##    ##  ##       ##     ## ##     ##       ## ##
     ##       #### ##     ## ######## ########  ##     ##  ######  ########

You're about to initialize a Firebase project in this directory:

  /Users/ryotaiwamoto/VSCode/flutter-devops-sample


=== Project Setup

First, let's associate this project directory with a Firebase project.
You can create multiple project aliases by running firebase use --add,
but for now we'll just set up a default project.

? Please select an option: Use an existing project
i  Don't want to scroll through all your projects? If you know your project ID, you can initialize it directly using firebase init --project <project_id>.

既に作成しているプロジェクトを選択します。
? Select a default Firebase project for this directory: flutter-devops-sample (flutter-devops-sample)
i  Using project flutter-devops-sample (flutter-devops-sample)

=== Hosting Setup

Your public directory is the folder (relative to your project directory) that
will contain Hosting assets to be uploaded with firebase deploy. If you
have a build process for your assets, use your build's output directory.

どのフォルダをデプロイするかを聞かれます。今回は ``build/web`` を指定します。
? What do you want to use as your public directory? build/web

シングルページアプリケーションを使用するかを聞かれます。今回は ``No`` を選択します。
? Configure as a single-page app (rewrite all urls to /index.html)? No

GitHub Actions でデプロイするために、GitHub との連携を行うか聞かれます。今回は ``Yes`` を選択します。
? Set up automatic builds and deploys with GitHub? Yes
✔  Wrote build/web/404.html
✔  Wrote build/web/index.html

i  Detected a .git folder at /Users/ryotaiwamoto/VSCode/flutter-devops-sample
i  Authorizing with GitHub to upload your service account to a GitHub repository's secrets store.

Visit this URL on this device to log in:
https://github.com/login/

Waiting for authentication...

✔  Success! Logged into GitHub as Ryotaewamoto

GitHub Actions のワークフローを作成するか聞かれます。GitHub のユーザ名/リポジトリ名で答えます。
? For which GitHub repository would you like to set up a GitHub workflow? (format: user/repository)
ryotaewamoto/flutter_DevOps_sample

✔  Created service account github-action-000000000 with Firebase Hosting admin permissions.
✔  Uploaded service account JSON to GitHub as secret FIREBASE_SERVICE_ACCOUNT_FLUTTER_DEVOPS_SAMPLE.
i  You can manage your secrets at https://github.com/ryotaewamoto/flutter_DevOps_sample/settings/secrets.

デプロイの前にビルドスクリプトを実行するか聞かれます。今回は ``Yes`` を選択します。
? Set up the workflow to run a build script before every deploy? Yes

実行するビルドスクリプトのコマンドを聞かれます。今回は ``flutter build web`` を指定します。
? What script should be run before every deploy? flutter build web

✔  Created workflow file /Users/ryotaiwamoto/VSCode/flutter-devops-sample/.github/workflows/firebase-hosting-pull-request.yml

プルリクエストをマージしたときに自動的にデプロイするか聞かれます。今回は ``Yes`` を選択します。
? Set up automatic deployment to your site's live channel when a PR is merged? Yes

デプロイするブランチを聞かれます。今回は ``develop`` を指定します。
? What is the name of the GitHub branch associated with your site's live channel? develop

✔  Created workflow file /Users/ryotaiwamoto/VSCode/flutter-devops-sample/.github/workflows/firebase-hosting-merge.yml

i  Action required: Visit this URL to revoke authorization for the Firebase CLI GitHub OAuth App:
https://github.com/settings/connections/applications/89cf50f02ac6aaed3484
i  Action required: Push any new workflow file(s) to your repo

i  Writing configuration info to firebase.json...
i  Writing project information to .firebaserc...

✔  Firebase initialization complete!
```

## 6. GitHub Actions の設定

今のままではうまく動作しないので、少しワークフローのコードを修正します。まず、``.github/actions/flutter_install/action.yaml`` を作成し、以下のコードを追加します。こちらは fvm を使用して Flutter をインストールするためのアクションです。

```yaml
name: Flutter Install
description: 'flutter install with fvm'

runs:
  using: 'composite'
  steps:
    - uses: actions/checkout@v2
    - uses: kuhnroyal/flutter-fvm-config-action@v1
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: ${{ env.FLUTTER_VERSION }}
        channel: ${{ env.FLUTTER_CHANNEL }}
        cache: true
        cache-key: flutter
        cache-path: ${{ runner.tool_cache }}/flutter
```


次に、``.github/workflows/firebase-hosting-pull-request.yml`` を以下のように修正します。こちらはプルリクエストを作成したときに実行されるワークフローです。``flutter build web`` でビルドを行い、``firebase deploy --only hosting:pr-<プルリクエスト番号>`` でデプロイを行います。また、``.github/workflows/firebase-hosting-merge.yml`` も同様の変更を行なってください。

```yaml
# This file was auto-generated by the Firebase CLI
# https://github.com/firebase/firebase-tools

name: Deploy to Firebase Hosting on PR
'on': pull_request
jobs:
  build_and_preview:
    if: '${{ github.event.pull_request.head.repo.full_name == github.repository }}'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

        # ここを追加
      - uses: ./.github/actions/flutter_install

      - run: flutter build web

      - uses: FirebaseExtended/action-hosting-deploy@v0
        with:
          repoToken: '${{ secrets.GITHUB_TOKEN }}'
          firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT_FLUTTER_DEVOPS_SAMPLE }}'
          projectId: flutter-devops-sample
```

これで、GitHub Actions でのデプロイの準備が完了しました。プルリクエストを作成したり、マージしたりしてみて、実際にデプロイが行われるか確認してみてください！

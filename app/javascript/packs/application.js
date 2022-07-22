// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// rails-ujsの読み込み
import Rails from "@rails/ujs"
// turbolinksの読み込み
import Turbolinks from "turbolinks"
// activestorageの読み込み
import * as ActiveStorage from "@rails/activestorage"
// actioncableの読み込み
import "channels"

// 上で読み込んだものを起動
Rails.start()
Turbolinks.start()
ActiveStorage.start()

import zh from "../lang/zh.json"
function lang(text){
    return zh[text]??text;
}
export default {
    install (app, options) {
        app.config.globalProperties.$t = lang
    }
}
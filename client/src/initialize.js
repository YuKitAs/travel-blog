import Router from 'vue-router'
import moment from 'moment'
import marked from 'marked'

export default function initialize(vue) {
  vue.use(Router)

  vue.filter('date', (date) => {
    if (!date) {
      return ''
    }
    return moment(date, 'YYYY-MM-DD').format('MMM. D, YYYY')
  })

  vue.filter('markdown', (markdown) => {
    if (!markdown) {
      return ''
    }
    return marked(markdown)
  })

  vue.config.productionTip = false
}

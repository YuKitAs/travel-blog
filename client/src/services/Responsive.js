// CSS constants are defined in @/assets/styles/_widths.sass

class Responsive {
  constructor() {
    this.MIN_PAGE_MARGIN_WIDTH = 25
    this.ARTICLE_WIDTH = 300
    this.SPACE_WIDTH = 50
    this.MENU_WIDTH = 150
    this.CONTENT_OFFSET = 35

    this.CONTENT_WIDTH =
      (numberOfArticles) => (this.SPACE_WIDTH + this.ARTICLE_WIDTH) * numberOfArticles + this.SPACE_WIDTH

    this.LARGE_SCREEN_MAX_WIDTH =
      this.MIN_PAGE_MARGIN_WIDTH + this.CONTENT_WIDTH(3) + this.MENU_WIDTH + this.MIN_PAGE_MARGIN_WIDTH
    this.MEDIUM_SCREEN_MAX_WIDTH =
      this.MIN_PAGE_MARGIN_WIDTH + this.CONTENT_WIDTH(2) + this.MENU_WIDTH + this.MIN_PAGE_MARGIN_WIDTH
    this.SMALL_SCREEN_MAX_WIDTH =
      this.MIN_PAGE_MARGIN_WIDTH + this.CONTENT_WIDTH(1) + this.MENU_WIDTH + this.MIN_PAGE_MARGIN_WIDTH
  }

  get SMALL() {
    return window.matchMedia(`(max-width: ${this.SMALL_SCREEN_MAX_WIDTH}px)`).matches
  }

  get MEDIUM_AND_UP() {
    return window.matchMedia(`(min-width: ${this.SMALL_SCREEN_MAX_WIDTH}px)`).matches
  }

  get LARGE_AND_UP() {
    return window.matchMedia(`(min-width: ${this.MEDIUM_SCREEN_MAX_WIDTH}px)`).matches
  }

  get XLARGE_AND_UP() {
    return window.matchMedia(`(min-width: ${this.LARGE_SCREEN_MAX_WIDTH}px)`).matches
  }
}

export default new Responsive()

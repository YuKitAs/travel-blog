import Sidebar from '@/components/app/Sidebar'
import SidebarSelectors from '@test/selector/components/app/Sidebar'
import VueTestComponentWrapper from 'vue-test-component-wrapper'

describe('Sidebar', () => {
  let wrapper

  beforeEach(async () => {
    wrapper = await VueTestComponentWrapper.mounted(Sidebar)
  })

  it('can be expanded and collapsed by the toggle button', async () => {
    await wrapper.setStyleProperty(SidebarSelectors.expandToggleButtonImage, 'display', 'block').untilAsyncTasksDone()
    await wrapper.click(SidebarSelectors.expandToggleButton).untilAsyncTasksDone()

    expect(wrapper.getStyleClasses(SidebarSelectors.content))
      .to.contain('tb-sidebar__content--expanded')
    expect(wrapper.getStyleClasses(SidebarSelectors.expandToggleButtonImage))
      .to.contain('tb-sidebar__expand-button--collapse')

    await wrapper.click(SidebarSelectors.expandToggleButton).untilAsyncTasksDone()

    expect(wrapper.getStyleClasses(SidebarSelectors.content))
      .not.to.contain('tb-sidebar__content--expanded')
    expect(wrapper.getStyleClasses(SidebarSelectors.expandToggleButtonImage))
      .not.to.contain('tb-sidebar__expand-button--collapse')
  })

  it('is collapsed if the router has been changed', async () => {
    await wrapper.setStyleProperty(SidebarSelectors.expandToggleButtonImage, 'display', 'block').untilAsyncTasksDone()
    await wrapper.click(SidebarSelectors.expandToggleButton).untilAsyncTasksDone()
    await wrapper.setRoute({name: 'Error'}).untilAsyncTasksDone()

    expect(wrapper.getStyleClasses(SidebarSelectors.content))
      .not.to.contain('tb-sidebar__content--expanded')
    expect(wrapper.getStyleClasses(SidebarSelectors.expandToggleButtonImage))
      .not.to.contain('tb-sidebar__expand-button--collapse')
  })

  it('cannot be expanded while being displayed in medium and up viewport', async () => {
    await wrapper.setStyleProperty(SidebarSelectors.expandToggleButtonImage, 'display', 'none').untilAsyncTasksDone()
    await wrapper.click(SidebarSelectors.expandToggleButton).untilAsyncTasksDone()

    expect(wrapper.getStyleClasses(SidebarSelectors.content))
      .not.to.contain('tb-sidebar__content--expanded')
    expect(wrapper.getStyleClasses(SidebarSelectors.expandToggleButtonImage))
      .not.to.contain('tb-sidebar__expand-button--collapse')
  })
})

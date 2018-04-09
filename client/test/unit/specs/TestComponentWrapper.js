import _ from 'lodash';
import Vue from 'vue';
import router from '@/router';

function buildSpy(object, methodName) {
  sinon.spy(object, methodName);
}

async function promisesResolved(timeout = 0) {
  return new Promise(resolve => setTimeout(resolve, timeout));
}

async function mountAsync(component, props = {}) {
  const Ctor = Vue.extend(component);
  const vm = new Ctor({ propsData: props, router }).$mount();

  await vm.$nextTick();
  await promisesResolved();

  return vm;
}

function removeNewlinesAndExtraWhitespace(textContent) {
  return textContent.replace(/\n */g, '').replace(/\s{2,}/g, ' ').trim();
}

export default class TestComponentWrapper {
  constructor(vm) {
    this.vm = vm;
    this.listenerStubs = {};
  }

  getRootElement() {
    return this.vm.$el;
  }

  getElement(selector) {
    return _.isNil(selector)
      ? this.getRootElement()
      : this.getRootElement().querySelector(selector);
  }

  getElements(selector) {
    return Array.from(this.getRootElement().querySelectorAll(selector));
  }

  hasElement(selector) {
    return this.getElements(selector).length !== 0;
  }

  getTextContent(selector) {
    return removeNewlinesAndExtraWhitespace(this.getElement(selector).textContent);
  }

  getTextContents(selector) {
    return this.getElements(selector)
      .map(element => removeNewlinesAndExtraWhitespace(element.textContent));
  }

  setListener(eventName) {
    this.listenerStubs[eventName] = () => {
    };
    buildSpy(this.listenerStubs, eventName);
    this.vm.$on(eventName, this.listenerStubs[eventName]);
  }

  getListener(eventName) {
    return this.listenerStubs[eventName];
  }

  setMethodStub(methodName) {
    return buildSpy(this.vm, methodName);
  }

  getMethodStub(methodName) {
    return this.vm[methodName];
  }

  getData(dataFieldName) {
    return _.get(this.vm.$data, dataFieldName);
  }

  setData(dataFieldName, value) {
    _.set(this.vm.$data, dataFieldName, value);
    return this;
  }

  getComputed(computedFieldName) {
    return _.get(this.vm, computedFieldName);
  }

  setComputed(computedFieldName, value) {
    _.set(this.vm, computedFieldName, value);
    return this;
  }

  getProperty(propFieldName) {
    return _.get(this.vm.$props, propFieldName);
  }

  setProperty(propFieldName, value) {
    _.set(this.vm.$props, propFieldName, value);
    return this;
  }

  invokeMethod(methodName, ...params) {
    return this.vm[methodName](...params);
  }

  getInputValue(selector) {
    return this.getElement(selector).value;
  }

  setInputValue(selector, value) {
    const inputElement = this.getElement(selector);
    inputElement.value = value;
    inputElement.dispatchEvent(new Event('input'));
    return this;
  }

  getSelectOptionValues(selector) {
    return Array.from(this.getElement(selector).querySelectorAll('option')).map(option => option.value);
  }

  setSelectOptionValue(selector, value) {
    const selectElement = this.getElement(selector);
    selectElement.value = value;
    selectElement.dispatchEvent(new Event('change'));
    return this;
  }

  isCheckboxChecked(selector) {
    return this.getElement(selector).checked;
  }

  toggleCheckbox(selector) {
    this.getElement(selector).click();
    return this;
  }

  click(selector) {
    this.getElement(selector).click();
    return this;
  }

  async untilAsyncTasksDone(timeout = 0) {
    await this.vm.$nextTick();
    await promisesResolved(timeout);
  }

  static async mounted(...args) {
    return new TestComponentWrapper(await mountAsync(...args));
  }
}

import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { concat, fn } from "@ember/helper";
import { action } from "@ember/object";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import DropdownMenu from "discourse/components/dropdown-menu";
import bodyClass from "discourse/helpers/body-class";
import icon from "discourse-common/helpers/d-icon";
import i18n from "discourse-common/helpers/i18n";
import DMenu from "float-kit/components/d-menu";

export default class TopicListLayoutToggle extends Component {
  @service router;
  @service topicListPreference;
  @service siteSettings;

  @tracked
  selectedOptionId = this.topicListPreference.preference || this.buttons[0].id;

  get shouldShow() {
    const currentRoute = this.router.currentRoute.name;
    const isDiscovery = currentRoute.includes("discovery");
    const isNotCategories = !currentRoute.includes("categories");

    return isDiscovery && isNotCategories;
  }

  get buttons() {
    const gistsAvailable =
      this.router.currentRoute.attributes?.list?.topics?.some(
        (topic) => topic.ai_topic_gist
      );

    let buttons = [
      {
        id: "table",
        label: "toggle_labels.table",
        icon: "discourse-table",
      },
    ];

    if (gistsAvailable) {
      buttons.push({
        id: "table-ai",
        label: "toggle_labels.table_gists",
        icon: "discourse-sparkles",
      });
    } else {
      buttons.push({
        id: "table-excerpts",
        label: "toggle_labels.table_excerpts",
        icon: "discourse-table",
      });
    }

    buttons.push({
      id: "cards",
      label: "toggle_labels.cards",
      icon: "discourse-cards",
    });

    return buttons;
  }

  get currentButton() {
    const selectedOptionId = this.selectedOptionId;

    let match = this.buttons.find((button) => button.id === selectedOptionId);

    if (!match && selectedOptionId.startsWith("table-")) {
      match = this.buttons.find((button) => button.id === "table");
    }

    return match;
  }

  @action
  onRegisterApi(api) {
    this.dMenu = api;
  }

  @action
  initialPreference() {
    const preference = this.topicListPreference.preference;
    this.selectedOptionId = preference || this.buttons[0].id;

    document
      .querySelector(".topic-list")
      .setAttribute("data-layout", preference);
  }

  @action
  onSelect(optionId) {
    this.selectedOptionId = optionId;
    document.querySelector(".topic-list").setAttribute("data-layout", optionId);
    this.topicListPreference.setPreference(optionId);
    this.dMenu.close();
  }

  <template>
    {{#if this.shouldShow}}
      {{bodyClass
        (concat "topic-list-layout-" this.topicListPreference.preference)
      }}
      <DMenu
        @modalForMobile={{true}}
        @autofocus={{true}}
        @identifier="topic-list-layout"
        @onRegisterApi={{this.onRegisterApi}}
        @triggerClass="btn-default btn-icon"
        {{didInsert this.initialPreference}}
      >
        <:trigger>
          {{icon this.currentButton.icon}}
        </:trigger>
        <:content>
          <DropdownMenu as |dropdown|>
            {{#each this.buttons as |button|}}
              <dropdown.item>
                <DButton
                  @translatedLabel={{i18n (themePrefix button.label)}}
                  @icon={{button.icon}}
                  class="btn-transparent"
                  @action={{fn this.onSelect button.id}}
                />
              </dropdown.item>
            {{/each}}
          </DropdownMenu>
        </:content>
      </DMenu>
    {{/if}}
  </template>
}

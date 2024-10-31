import Component from "@glimmer/component";
import { service } from "@ember/service";

export default class TopicListImage extends Component {
  @service topicListPreference;
  @service router;

  get shouldShow() {
    const currentRoute = this.router.currentRoute.name;
    const isDiscovery = currentRoute.includes("discovery");

    return this.topicListPreference.preference === "cards" && isDiscovery;
  }

  <template>
    {{#if this.shouldShow}}
      {{#if @outletArgs.topic.thumbnails}}
        <img
          class="thumbnail"
          width={{@outletArgs.topic.thumbnails.0.width}}
          height={{@outletArgs.topic.thumbnails.0.height}}
          src={{@outletArgs.topic.thumbnails.0.url}}
        />
      {{/if}}
    {{/if}}
  </template>
}

import Component from "@glimmer/component";
import { service } from "@ember/service";
import icon from "discourse-common/helpers/d-icon";

export default class TopicListReplyCountIcon extends Component {
  @service site;
  @service topicThumbnails; // from Topic Thumbnails theme component

  get shouldShow() {
    return !this.site.mobileView && !this.topicThumbnails?.shouldDisplay;
  }

  <template>
    {{#if this.shouldShow}}
      {{icon "far-comment"}}
    {{/if}}
  </template>
}

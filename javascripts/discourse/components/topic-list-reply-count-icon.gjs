import Component from "@glimmer/component";
import { service } from "@ember/service";
// import PostersColumn from "discourse/components/topic-list/posters-column";
import icon from "discourse-common/helpers/d-icon";

export default class TopicListReplyCountIcon extends Component {
  @service site;
  @service topicListPreference;
  @service topicThumbnails; // from Topic Thumbnails theme component

  get shouldShow() {
    const isCard = this.topicListPreference.preference === "cards";

    return !this.topicThumbnails?.shouldDisplay && isCard;
  }

  <template>
    {{#if this.shouldShow}}
      {{#if this.site.mobileView}}
        {{#if @outletArgs.topic.featuredUsers}}
          <PostersColumn @posters={{@outletArgs.topic.featuredUsers}} />
        {{/if}}
      {{/if}}
      {{icon "far-comment"}}
    {{/if}}
  </template>
}

import { apiInitializer } from "discourse/lib/api";
import icon from "discourse-common/helpers/d-icon";

export default apiInitializer("1.14.0", (api) => {
  const site = api.container.lookup("service:site");
  api.renderInOutlet("topic-list-before-reply-count", <template>
    {{#unless site.mobileView}}
      {{icon "far-comment"}}
    {{/unless}}
  </template>);
});

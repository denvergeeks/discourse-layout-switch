import { apiInitializer } from "discourse/lib/api";
import icon from "discourse-common/helpers/d-icon";

export default apiInitializer("1.14.0", (api) => {
  api.renderInOutlet("topic-list-before-reply-count", <template>
    {{icon "far-comment"}}
  </template>);
});

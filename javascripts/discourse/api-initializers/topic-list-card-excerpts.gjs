import { apiInitializer } from "discourse/lib/api";
import TopicListExcerpt from "../components/topic-list-excerpt";

export default apiInitializer("1.14.0", (api) => {
  api.renderInOutlet("topic-list-main-link-bottom", <template>
    <TopicListExcerpt
      @outlet="topic-list-main-link-bottom"
      @topic={{@outletArgs.topic}}
    />
  </template>);
});

<div id="about-session">
    {% if is_subscribed and user_session_time != -0 and user_session_time >= 1 %}
    <div class="alert alert-info">
        {{ 'AlreadyRegisteredToSession'|get_lang }}
    </div>
    {% elseif is_subscribed and user_session_time < 1 %}
    <div class="alert alert-warning">
        {{ 'YourSessionTimeIsExpired'|get_lang }}
    </div>
    {% endif %}
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="row">
                <div class="col-md-8">
                    <h2 class="session-title">{{ session.name }}</h2>
                    {% if show_tutor %}
                        <div class="session-tutor">
                            <em class="fa fa-user"></em> {{ 'SessionGeneralCoach'|get_lang }}: <em>{{ session.generalCoach.getCompleteName() }}</em>
                        </div>
                    {% endif %}
                    {% if session.getShowDescription() %}
                        <div class="session-description">
                            {{ session.getDescription() }}
                        </div>
                    {% endif %}
                    <div class="share-social-media">
                        <ul class="sharing-buttons">
                            <li>
                                {{ "ShareWithYourFriends"|get_lang }}
                            </li>
                            <li>
                                <a href="https://www.facebook.com/sharer/sharer.php?{{ {'u': page_url }|url_encode }}"
                                   target="_blank" class="btn btn-facebook btn-inverse btn-xs">
                                    <em class="fa fa-facebook"></em> Facebook
                                </a>
                            </li>
                            <li>
                                <a href="https://twitter.com/home?{{ {'status': session.getName() ~ ' ' ~ page_url }|url_encode }}"
                                   target="_blank" class="btn btn-twitter btn-inverse btn-xs">
                                    <em class="fa fa-twitter"></em> Twitter
                                </a>
                            </li>
                            <li>
                                <a href="https://www.linkedin.com/shareArticle?{{ {'mini': 'true', 'url': page_url , 'title': session.getName() }|url_encode }}"
                                   target="_blank" class="btn btn-linkedin btn-inverse btn-xs">
                                    <em class="fa fa-linkedin"></em> Linkedin
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="session-info">
                        <div class="date">
                            <p>
                                {% if session.duration %}
                                    {{ 'SessionDurationXDaysLeft'|get_lang|format(session.duration) }}
                                {% else %}
                                    {{ session_date.display }}
                                {% endif %}
                            </p>
                        </div>
                        {% if is_premiun == false %}
                            <h5>{{ 'CourseSubscription'|get_lang }}</h5>
                            <div class="session-subscribe">
                                {% if _u.logged and not is_subscribed %}
                                    {{ subscribe_button }}
                                {% elseif not _u.logged %}
                                {% if 'allow_registration'|api_get_setting != 'false' %}
                                    <a href="{{ _p.web_main ~ 'auth/inscription.php' ~ redirect_to_session }}" class="btn btn-success btn-block btn-lg">
                                        <i class="fa fa-pencil" aria-hidden="true"></i> {{ 'SignUp'|get_lang }}
                                    </a>
                                {% endif %}
                                {% endif %}
                            </div>
                        {% else %}
                        <div class="session-price">
                            <div class="sale-price">
                                {{ 'SalePrice'|get_lang }}
                            </div>
                            <div class="price-text">
                                {{ is_premiun.iso_code }} {{ is_premiun.price }}
                            </div>
                            <div class="buy-box">
                                <a href="{{ _p.web }}plugin/buycourses/src/process.php?i={{ is_premiun.product_id }}&t={{ is_premiun.product_type }}" class="btn btn-lg btn-primary btn-block">{{ 'BuyNow'|get_lang }}</a>
                            </div>
                        </div>
                        {% endif %}
                        {% if has_requirements %}
                            <div class="session-requirements">
                                <h5>{{ 'RequiredSessions'|get_lang }}</h5>
                                {% for sequence in sequences %}
                                    {% if sequence.requirements %}
                                        <p>
                                            {{ sequence.name }} :
                                            {% for requirement in sequence.requirements %}
                                                <a href="{{ _p.web ~ 'session/' ~ requirement.getId ~ '/about/' }}">
                                                    {{ requirement.getName }}
                                                </a>
                                            {% endfor %}
                                        </p>
                                    {% endif %}
                                {% endfor %}
                            </div>
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
    </div>

    {% for course_data in courses %}
        {% set course_video = '' %}
        {% for extra_field in course_data.extra_fields %}
            {% if extra_field.value.getField().getVariable() == 'video_url' %}
                {% set course_video = extra_field.value.getValue() %}
            {% endif %}
        {% endfor %}
        <div class="panel panel-default panel-course">
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-5">
                        {% if course_video %}
                            <div class="embed-responsive embed-responsive-16by9">
                                {{ essence.replace(course_video) }}
                            </div>
                        {% else %}
                            <div class="course-image">
                                <img src="{{ course_data.image }}" class="img-rounded img-responsive" width="100%">
                            </div>
                        {% endif %}

                    </div>
                    <div class="col-sm-7">
                        {% if courses|length > 1 %}
                        <div class="course-title">
                            <h3>{{ course_data.course.getTitle }}</h3>
                        </div>
                        {% endif %}
                        <div class="course-description">
                            {{ course_data.description.getContent }}
                        </div>
                    </div>
                </div>
                {% if course_data.tags %}
                <div class="panel-tags">

                    <ul class="list-inline course-tags">
                        <li>{{ 'Tags'|get_lang }} :</li>
                        {% for tag in course_data.tags %}
                        <li class="tag-value">
                            <span>{{ tag.getTag }}</span>
                        </li>
                        {% endfor %}
                    </ul>
                </div>
                {% endif %}
            </div>
        </div>

        <section class="course">
        <div class="row">
            <div class="col-md-8">
                <h3 class="sub-title">{{ "CourseInformation"|get_lang }}</h3>
                <div class="course-information read-more-area">
                    {% if course_data.objectives %}
                    <div class="topics">
                        <h4 class="title-info"><em class="fa fa-book"></em> {{ course_data.objectives.getTitle }}</h4>
                        <div class="content-info">
                            {{ course_data.objectives.getContent }}
                        </div>
                    </div>
                    {% endif %}

                    {% if course_data.topics %}
                    <div class="topics">
                        <h4 class="title-info"><em class="fa fa-book"></em> {{ course_data.topics.getTitle }}</h4>
                        <div class="content-info">
                            {{ course_data.topics.getContent }}
                        </div>
                    </div>
                    {% endif %}

                    {% if course_data.methodology %}
                    <div class="topics">
                        <h4 class="title-info"><em class="fa fa-book"></em> {{ course_data.methodology.getTitle }}</h4>
                        <div class="content-info">
                            {{ course_data.methodology.getContent }}
                        </div>
                    </div>
                    {% endif %}

                    {% if course_data.material %}
                    <div class="topics">
                        <h4 class="title-info"><em class="fa fa-book"></em> {{ course_data.material.getTitle }}</h4>
                        <div class="content-info">
                            {{ course_data.material.getContent }}
                        </div>
                    </div>
                    {% endif %}

                    {% if course_data.resources %}
                    <div class="topics">
                        <h4 class="title-info"><em class="fa fa-book"></em> {{ course_data.resources.getTitle }}</h4>
                        <div class="content-info">
                            {{ course_data.resources.getContent }}
                        </div>
                    </div>
                    {% endif %}

                    {% if course_data.assessment %}
                    <div class="topics">
                        <h4 class="title-info"><em class="fa fa-book"></em> {{ course_data.assessment.getTitle }}</h4>
                        <div class="content-info">
                            {{ course_data.assessment.getContent }}
                        </div>
                    </div>
                    {% endif %}

                    {% if course_data.custom %}
                    {% for custom in course_data.custom %}
                    <div class="topics">
                        <h4 class="title-info"><em class="fa fa-book"></em> {{ custom.getTitle }}</h4>
                        <div class="content-info">
                            {{ custom.getContent }}
                        </div>
                    </div>
                    {% endfor %}
                    {% endif %}
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        {% if course_data.coaches %}
                        <div class="panel-teachers">
                            <h3 class="sub-title">{{ "Coaches"|get_lang }}</h3>
                            {% for coach in course_data.coaches %}
                            <div class="coach-information">
                                <div class="coach-header">
                                    <div class="coach-avatar">
                                        <img class="img-circle img-responsive" src="{{ coach.image }}" alt="{{ coach.complete_name }}">
                                    </div>
                                    <div class="coach-title">
                                        <h4>{{ coach.complete_name }}</h4>
                                        {% if coach.diploma %}
                                        <p>{{ coach.diploma }}</p>
                                        {% endif %}
                                    </div>
                                </div>
                                {% if coach.openarea %}
                                <div class="open-area">
                                    <p>{{ coach.openarea }}</p>
                                </div>
                                {% endif %}
                                {% for coach_extra_field in coach.extra_fields %}
                                <dl class="coach-extrafield">
                                    <dt class="extrafield_dt dt_{{coach_extra_field.value.getField().getVariable()}}">{{ coach_extra_field.value.getField().getDisplayText() }}</dt>
                                    <dd class="extrafield_dd dd_{{coach_extra_field.value.getField().getVariable()}}">{{ coach_extra_field.value.getValue() }}</dd>
                                </dl>
                                {% endfor %}
                            </div>
                            {% endfor %}
                        </div>
                        {% endif %}
                    </div>
                </div>

            </div>
        </div>
        </section>
    {% endfor %}
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $('.course-information').readmore({
            speed: 100,
            lessLink: '<a class="hide-content" href="#">{{ 'SetInvisible' | get_lang }}</a>',
            moreLink: '<a class="read-more" href="#">{{ 'ReadMore' | get_lang }}</a>',
            collapsedHeight: 500,
            heightMargin: 100
        });
        $('.open-area').readmore({
            speed: 100,
            lessLink: '<a class="hide-content" href="#">{{ 'SetInvisible' | get_lang }}</a>',
            moreLink: '<a class="read-more" href="#">{{ 'ReadMore' | get_lang }}</a>',
            collapsedHeight: 90,
            heightMargin: 20
        });
    });
</script>
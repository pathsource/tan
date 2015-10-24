namespace :db do
  task init_data: :environment do
    Project.delete_all
    Project.create([
      { address: '昙华林', name: '昙华林有石瑛先生故居，走，去看看', lat: 30.552127, lon: 114.309425, sponsor: 'http://7xleh2.dl1.z0.glb.clouddn.com/sf_logo.png', description: '石瑛先生是孙中山的亲密战友和忠实信徒，是欧洲同盟会支部的创建人、负责人，为推翻帝制、建立民国立下了汗马功劳。石瑛在创建国立武昌大学任校长时，始在武昌区三义村置私人住宅一幢二层小楼。故居是辛亥首义革命前辈在武汉市内难得的一处故宅，对研究和展示辛亥革命历史和武汉名城发展轨迹具有极高的价值。让我们去故居里去找寻那年的痕迹。', image: 'http://7xleh2.dl1.z0.glb.clouddn.com/Top%20pic.png'},
      { address: '青年大教堂', name: '到青年大教堂给Hackathon点赞', lat: 30.502404, lon: 114.407113, sponsor: 'http://7xleh2.dl1.z0.glb.clouddn.com/sponsor_logo.png', description: '此时此刻， 一群开发者，相聚在光谷青年大教堂，以他们想要的方式，在做着他们想做的事情。 黑客马拉松（Hackathon）编程大赛自最初被引进国内，便引起开发者的狂热响应。一群有创造力的人，去做极富创造力的事，再酷不过了。出发， 给他们点赞吧！', image: 'http://7xleh2.dl1.z0.glb.clouddn.com/Top%20pic.png'},
      { address: '红楼', name: '拾起1911的那段大历史', lat: 30.542217 , lon: 114.306489, description: '宋庆龄名誉主席为红楼和纪念馆亲笔题写了“武昌起义军政府旧址”和“辛亥革命武昌起义纪念馆”两块匾额, 红楼堂屋有个神秘的东西， 去找找看。', image: 'http://7xleh2.dl1.z0.glb.clouddn.com/Top%20pic.png'},
      { address: '省博', name: '对， 这次去省博去找个人', lat: 30.561931 , lon: 114.365500, image: 'http://7xleh2.dl1.z0.glb.clouddn.com/Top%20pic.png'},
      { address: '黄鹤楼', name: '长江边的那块匾， 你还记得吗？', lat: 30.544636 , lon: 114.302537, image: 'http://7xleh2.dl1.z0.glb.clouddn.com/Top%20pic.png'},
      { address: '武汉大学', name: '看樱花， 不了， 去找那个诗人', lat: 30.533289 , lon: 114.358140, image: 'http://7xleh2.dl1.z0.glb.clouddn.com/Top%20pic.png'}
    ])
  end

  task init_puzzles: :environment do
    Project.find_by(address: '昙华林').create_puzzle(content: '艺术沙龙', hint: '钱基博所居住的房间', answer: SecureRandom.base64(32))
    Project.find_by(address: '青年大教堂').create_puzzle(content: 'row2pa', hint: 'PathSource', answer: SecureRandom.base64(32))
  end

  task add_location_info: :environment do
    Project.find_by(address: '昙华林').update_attributes(location: '武昌区昙华林三义村特1号')
    Project.find_by(address: '青年大教堂').update_attributes(location: '武汉光谷世界城意大利风情街')
    Project.find_by(address: '红楼').update_attributes(location: '武汉市武昌区武珞路1号')
  end
end
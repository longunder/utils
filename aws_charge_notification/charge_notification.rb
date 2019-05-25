require 'aws-sdk'

ENV['AWS_ACCESS_KEY_ID'] = "hogehoge"
ENV['AWS_SECRET_ACCESS_KEY'] = "hogehoge"
ENV['AWS_REGION'] = "hogehoge"
arn = "arn:aws:sns:us-east-1:hogehoge:hogehoge" # ARN of Amazon SNS

#get data
metric = Aws::CloudWatch::Metric.new('AWS/Billing', 'EstimatedCharges')

statistics = metric.get_statistics({
 dimensions: [
   {
     name: "Currency", # required
     value: "USD", # required
   },
 ],
  start_time: Time.now - 43200, # required
  end_time: Time.now, # required
  period: 43200, # required
  statistics: ["Maximum"], # accepts SampleCount, Average, Sum, Minimum, Maximum
})

# notification
sns = Aws::SNS::Resource.new()
topic = sns.topic("#{arn}")

topic.publish({
  message: "#{statistics[:datapoints][0][:timestamp]},$#{statistics[:datapoints][0][:maximum]}",
  subject: "[Estimated Charges] $#{statistics[:datapoints][0][:maximum]}"
})

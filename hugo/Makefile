build: public


public:
	hugo

clean:
	rm -rf public

upload: public
	aws --profile personal --region eu-west-2 s3 cp --recursive public s3://nickrw-site/

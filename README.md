# Mongo ABAC

In this gem, we propose a novel methodology for enabling ABAC specifically in MongoDB, one of the most popular NoSQL databases in use today. Our approach shows how to first specify ABAC access control policies and then enforce them when an actual access request has been made.

MongoDB Wire Protocol is used for extracting and processing appropriate information from the requests. We also present a method for supporting dynamic access decisions using environmental attributes and handling of ad-hoc access requests through digitally signed user attributes.


# adapted from book Programming Robots with ROS

#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import LaserScan

def scan_callback(msg):
	global g_range_ahead
	g_range_ahead = min(msg.ranges)
	
g_range_ahead = 1
scan_sub = rospy.Subscriber('scan', LaserScan, scan_callback)
cmd_vel_pub = rospy.Publisher('cmd_vel', Twist, queue_size = 1)
rospy.init_node('wander')
state_change_time = rospy.Time.now()
driving_forward = True
rate = rospy.Rate(10)

while not rospy.is_shutdown():
	if driving_forward:
		if(g_range_ahead < 0.5 or rospy.Time.now() > state_change_time):
		driving_forward = False
		state_change_time = rospy.Time.now() + rospy.Duration(5)
	else:
		if rospy.Time.now() > state_change_time:
		driving_forward = True
		state_change_time = rospy.Time.now() + rospy.Duration(30)
		
twist = Twist()

if driving_forward:
	twist.liner.x = 1
else:
	twist.angular.z = 1
cmd_vel_pub.publish(twist)

rate.sleep()
	
	
	
	
	
	

cmd_vel_pub = rospy.Publisher('cmd_vel', Twist, queue_size = 1)
rospy.init_node('red_light_green_light')

red_light_twist = Twist()
green_light_twist = Twist()
green_light_twist.linear.x = 0.5

driving_forward = False
light_change_time = rospy.Time.now()
rate = rospy.Rate(10)

while not rospy.is_shutdown():
	if driving_forward:
		cmd_vel_pub.publish(green_light_twist)
	else:
		cmd_vel_pub.publish(red_light_twist)
	if light_change_time > rospy.Time.now():
		driving_forward = not driving_forward
		light_change_time = rospy.Time.now() + rospy.Duration(3)
	rate.sleep()
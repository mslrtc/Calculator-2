//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Yingyu on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

@synthesize display;
@synthesize showFoperator;
@synthesize showSpecial;
@synthesize sqrXButton;
@synthesize radsigXButton;
@synthesize expButton;
@synthesize tensqrButton;
@synthesize fracButton;
@synthesize msubButton;
@synthesize clrcfButton;

double finalno = 0;
int flag = 0;//标记计算符号次数
int ran;


// 初始化计算器
- (void)viewDidLoad 
{
	display.text = @"";
	showFoperator.text = @"";
	showSpecial.text = @"";
	operator = @"=";
	fstOperand = 0;
	sumOperand = 0;
	bBegin = YES;
	
}

// 按键事件处理
-(IBAction)buttonClicked:(id)sender 
{
	UIButton *btn = (UIButton *)sender;
	int tag = btn.tag;
	
	switch (tag) 
	{
		// 初始化清屏
		case clearBtn:	// C    1
            flag = 0;
            finalno = 0;
			[self clearDisplay];
			break;
		
		// 退格
		case backBtn:	// ←    2
			[self backSpace];
			break;

		// 双操作数运算符
		case plusBtn:	// +    3
		case subBtn:	// -    4
		case mulBtn:	// x    5
		case divBtn:	// ÷    6
		case sqrXBtn:	// yⁿ   7
		case radsigXBtn:// ⁿ√y  8
		case equalBtn:	// =    9
			[self inputDoubleOperator:btn.titleLabel.text];
			break;
			
		// 增加小数点
		case dotBtn:	// .    10
			[self addDot];
			break;
			
		// 增加正负号
		case signBtn:	// +/-  11
			[self addSign];
			break;
			
		// 单操作数运算符
		case sqr2Btn:	// x²   12
		case radsig2Btn:	// √x	13
		case logeBtn:	// ln	14
		case log10Btn:	// log	15
		case expBtn:		// eⁿ	16
		case tensqrBtn:	// 10ⁿ	17
		case percBtn:	// %	18
		case fracBtn:	// 1/x	19
			[self inputSingleOperator:btn.titleLabel.text];
			break;
	

		// 数字分支
		default:
            if (flag > 2) {
                display.text = @"";
                flag --;
            }
			[self inputNumber:btn.titleLabel.text];
			break;
	}
}

// C方法
- (void)clearDisplay
{
	display.text = @"";
	showFoperator.text = @"C";
	operator = @"=";
	fstOperand = 0;
	sumOperand = 0;
	bBegin = YES;
}

// ←方法
- (void)backSpace
{
	showFoperator.text = @"←";
	
	if (backOpen) 
	{
		if (display.text.length == 1)
		{
			display.text = @"";
		}
		else if (![display.text isEqualToString:@""])
		{
			display.text = [display.text substringToIndex:display.text.length -1];
		}
	}
}

// 双操作数运算方法 
- (void)inputDoubleOperator: (NSString *)dbopt
{
	showFoperator.text = dbopt;
	backOpen = NO;
	if (flag < 2) {
        if(![display.text isEqualToString:@""])
        {
            fstOperand = [display.text doubleValue];
            
            if(bBegin)
            {
                operator = dbopt;
            }
            else
            {
                    if([operator isEqualToString:@"="])
                    {
                        finalno = fstOperand;
                        sumOperand = fstOperand;
                        flag = 0;
                    }
                    else if([operator isEqualToString:@"+"])
                    {
                        finalno += fstOperand;
                        ran = (arc4random() % 10) + 1;
                        NSLog(@"random is %u", ran );
                        NSLog(@"flag is %i", flag );
                        sumOperand += (fstOperand+ ran);
                        NSLog(@"sumOperand is %g", sumOperand);
                        display.text = [NSString stringWithFormat:@"%g",sumOperand];
                        flag ++;

                    }
                    else if([operator isEqualToString:@"-"])
                    {
                        finalno -= fstOperand;
                        sumOperand -= fstOperand+(arc4random() % 10) + 1;
                        display.text = [NSString stringWithFormat:@"%g",sumOperand];
                        flag ++;

                    }
                    else if([operator isEqualToString:@"x"])
                    {
                        finalno *= fstOperand;
                        sumOperand *= fstOperand+(arc4random() % 10) + 1;
                        display.text = [NSString stringWithFormat:@"%g",sumOperand];
                        flag ++;

                    }
                    else if([operator isEqualToString:@"÷"])
                    {
                        if((fstOperand+(arc4random() % 10) + 1)!= 0)
                        {
                            finalno /= fstOperand;
                            sumOperand /= fstOperand+(arc4random() % 10) + 1;
                            display.text = [NSString stringWithFormat:@"%g",sumOperand];
                            flag ++;

                        }
                        else
                        {
                            display.text = @"nan";
                            operator= @"=";
                        }
                    }
                    else if ([operator isEqualToString:@"xⁿ"])
                    {
                        finalno = pow(sumOperand, fstOperand);
                        sumOperand = pow(sumOperand, (fstOperand+(arc4random() % 10) + 1));
                        display.text = [NSString stringWithFormat:@"%g",sumOperand];
                        flag ++;

                    }
                    else if ([operator isEqualToString:@"ⁿ√x"])
                    {
                        finalno = pow(sumOperand, 1/fstOperand);
                        sumOperand = pow(sumOperand, 1/(fstOperand+(arc4random() % 10) + 1));
                        display.text = [NSString stringWithFormat:@"%g",sumOperand];
                        flag ++;

                    }
                    
                    bBegin= YES;
                    operator= dbopt;
                }
        }
    
        }
        else{
                display.text = [NSString stringWithFormat:@"%g" , finalno];
                flag ++;
            
        }
		
}

// 增加.方法
- (void)addDot
{
	showFoperator.text = @".";
	
	if(![display.text isEqualToString:@""] && ![display.text isEqualToString:@"-"])
	{
		NSString *currentStr = display.text;
		BOOL notDot = ([display.text rangeOfString:@"."].location == NSNotFound);
		if (notDot) 
		{
			currentStr= [currentStr stringByAppendingString:@"."];
			display.text= currentStr;
		}
	}
}

// 增加+/-方法
- (void)addSign
{
	showFoperator.text = @"+/-";
	
	if(![display.text isEqualToString:@""] && ![display.text isEqualToString:@"0"] && ![display.text isEqualToString:@"-"])
	{
		double number = [display.text doubleValue];
		number = number*(-1);
		display.text= [NSString stringWithFormat:@"%g",number];
		
		if(bBegin)
		{
			sumOperand = number;
		}
	}    
}

// 单操作数运算方法
- (void)inputSingleOperator: (NSString *)sgopt
{
	showFoperator.text = sgopt;
	backOpen = NO;
	
	if(![display.text isEqualToString:@""])
	{
		operator = sgopt;
		fstOperand = [display.text doubleValue];
        flag = 0;
		
		if([operator isEqualToString:@"x²"])
		{
			sumOperand = pow((fstOperand +(arc4random() % 10) + 1), 2);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"√x"])
		{
			sumOperand = sqrt(fstOperand+(arc4random() % 10) + 1);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"ln"])
		{
			sumOperand = log(fstOperand+(arc4random() % 10) + 1);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"log"])
		{
			sumOperand = log10(fstOperand+(arc4random() % 10) + 1);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"eⁿ"])
		{
			sumOperand = exp(fstOperand+(arc4random() % 10) + 1);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"10ⁿ"])
		{
			sumOperand = pow(10 , fstOperand+(arc4random() % 10) + 1);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"%"])
		{
			sumOperand = (fstOperand+(arc4random() % 10) + 1) / 100;
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"1/x"])
		{
			if ((fstOperand+(arc4random() % 10) + 1)!= 0)
			{
				sumOperand = 1 / (fstOperand+(arc4random() % 10) + 1);
				display.text= [NSString stringWithFormat:@"%g",sumOperand];
			}
			else 
			{
				display.text = @"nan";
			}
		}
		bBegin = YES;
	}
}





// 清空cf变量方法
- (void)clearCf
{
    
	showFoperator.text = @"CLR CF";
}

// 数字输入方法
- (void)inputNumber: (NSString *)nbstr
{	
	backOpen = YES;
	
	if(bBegin)
	{
		showFoperator.text = @"";
		display.text = nbstr;
	}
	else
	{
		display.text = [display.text stringByAppendingString:nbstr];
	}
	bBegin = NO;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.display = nil;
	self.showFoperator = nil;
	self.showSpecial = nil;
	self.sqrXButton = nil;
	self.radsigXButton = nil;
	self.expButton = nil;
	self.tensqrButton = nil;
	self.fracButton = nil;
	self.msubButton = nil;
	self.clrcfButton = nil;
}


- (void)dealloc {
	[display release];
	[showFoperator release];
	[showSpecial release];
	[sqrXButton release];
	[radsigXButton release];
	[expButton release];
	[tensqrButton release];
	[fracButton release];
	[msubButton release];
	[clrcfButton release];
    [super dealloc];
}

@end

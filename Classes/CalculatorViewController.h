//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Yingyu on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <math.h>

#define clearBtn	1	// C
#define backBtn		2	// ←

#define plusBtn     3	// +
#define subBtn      4	// -
#define mulBtn      5	// x
#define divBtn      6	// ÷
#define sqrXBtn		7	// xⁿ
#define radsigXBtn	8	// ⁿ√x
#define equalBtn    9	// =

#define dotBtn      10	// .
#define signBtn     11	// +/-

#define sqr2Btn		12	// x²
#define radsig2Btn	13	// √x
#define logeBtn		14	// ln
#define log10Btn	15	// log
#define expBtn		16	// eⁿ
#define tensqrBtn	17	// 10ⁿ
#define percBtn		18	// %
#define fracBtn		19	// 1/x


#define clrcfBtn	38	// CLR CF

@interface CalculatorViewController : UIViewController {
	
	UITextField *display;
	UILabel *showFoperator;
	UILabel *showSpecial;
	UIButton *sqrXButton;
	UIButton *radsigXButton;
	UIButton *expButton;
	UIButton *tensqrButton;
	UIButton *fracButton;
	UIButton *msubButton;
	UIButton *clrcfButton;
	
	BOOL bBegin;
	BOOL backOpen;
	
	double fstOperand;
	double sumOperand;

    
    
		
	NSString *operator;
}

@property (nonatomic, retain) IBOutlet UITextField *display;
@property (nonatomic, retain) IBOutlet UILabel *showFoperator;
@property (nonatomic, retain) IBOutlet UILabel *showSpecial;
@property (nonatomic, retain) IBOutlet UIButton	*sqrXButton;
@property (nonatomic, retain) IBOutlet UIButton	*radsigXButton;
@property (nonatomic, retain) IBOutlet UIButton	*expButton;
@property (nonatomic, retain) IBOutlet UIButton	*tensqrButton;
@property (nonatomic, retain) IBOutlet UIButton	*fracButton;
@property (nonatomic, retain) IBOutlet UIButton	*msubButton;
@property (nonatomic, retain) IBOutlet UIButton *clrcfButton;

- (void)clearDisplay;								// 初始化清屏方法声明
- (void)backSpace;									// 退格方法声明

- (void)inputDoubleOperator: (NSString *)dbopt;		// 双操作数运算方法声明

- (void)addDot;										// 增加.方法声明
- (void)addSign;									// 增加+/-方法声明

- (void)inputSingleOperator: (NSString *)sgopt;		// 单操作数运算方法声明


- (void)clearCf;									// 清空cf变量方法声明

- (void)inputNumber: (NSString *)nbstr;				// 数字输入方法声明

- (IBAction)buttonClicked:(id)sender;				// 按键管理事件声明

@end

